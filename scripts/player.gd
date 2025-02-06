extends Unit
class_name Player

#Ноги, определяющие поверхность
var feet: UnitFeet:
	get():
		if not feet and has_node("Feet"): feet = get_node("Feet")
		return feet

var eyes: RayCast3D:
	get():
		if not eyes and has_node("Camera/Eyes"): eyes = get_node("Camera/Eyes")
		return eyes

#Доступ к интерфейсу
var interface: UnitInterface:
	get():
		if not interface and has_node("Interface"): interface = get_node("Interface")
		return interface

#Камера. Отдельный скрипт не нужен, т.к. игрок один единственный
@onready var camera: Camera3D = $Camera

#Таймер для энергии
@onready var energy_timer: Timer = $Energy

#Скорость движения
var speed: float = 5
var walk_speed: float = speed
var run_speed: float = speed*2

signal energy_changed()
var max_energy: float = 50
var energy: float = max_energy:
	set(val):
		energy = val
		energy_changed.emit()

#Гравитация
var gravity: float = MG.gravity

#Скорость прыжка
var jump_force: int = 5

#лимиты обзора
var view_limit_v: Vector2 = Vector2(deg_to_rad(70), -deg_to_rad(90))
var view_limit_h: Vector2

#сидячее место
var seat: Bench

#захват игрока
var is_captured: bool = false

func set_captured_state(flag):
	body.is_active = !flag
	body.get_node("Collision").disabled = flag
	is_captured = flag

#Цель, на которую смотрит игрок
var focused_target: Unit:
	get():
		var body: PhysicsBody3D = eyes.get_collider()
		if not body or not body.owner is Unit: return null
	
		var target: Unit = body.owner
		return target

#Тестирующая функция
func test() -> void:
	storage = Storage.new()
	storage.resize(15) #= размеру Inventory
	storage.add_item(MS.create_item("scissors"))

func _init() -> void: test()

#Определение игрока
func _ready() -> void:
	MG.set_player(self)
	interface.is_active = true

func _process(_delta: float) -> void:
	if not is_captured:
		#Звук шагов
		if body.velocity and body.is_on_floor(): feet.play_surface_sfx()
		else: if feet.audio.playing: feet.audio.stop()
	
		#Определение бега
		if Input.is_action_pressed("run"): run()
		elif energy != max_energy:
			if energy_timer.is_stopped():
				energy = min(energy+1, max_energy)
				speed = walk_speed
				energy_timer.start()
	
	#Подсказка
	var target: Unit = focused_target
	if target:
		var item: Item = storage.active_item
		if item and item.is_fit(target): interface.clue.text = item.clue_text
		else: interface.clue.text = target.clue_text
	else: interface.clue.text = ""

#Определение направления инпута
#и передача его телу
#а также поворот камеры
#и использование предметов
func _input(event: InputEvent) -> void:
	#поворот камеры
	if event is InputEventMouseMotion and ML.mouse_capture: camera_rotation(event)
	
	#направление и передача его телу
	var input_dir: Vector2 = Input.get_vector("left", "right", "up", "down") if ML.mouse_capture else Vector2.ZERO
	body.dir = input_dir
	
	#прыжок
	if Input.is_action_just_pressed("jump"):
		if is_captured: stand_up()
		else: body.jump()
	
	#использование предмета
	if ML.is_key_just_pressed(event, KEY_E):
		var target: Unit = focused_target
		action(target)
	
	#подъем если силит

#Расчет поворота камеры на основе входящего события
func camera_rotation(event: InputEventMouseMotion) -> void:
	#поворот тела по горизонтали
	rotate_y(-event.relative.x * ML.sens)
	if view_limit_h: rotation.y = clampf(rotation.y, view_limit_h.y, view_limit_h.x)
	#поворот камеры по вертикали
	camera.rotate_x(-event.relative.y * ML.sens)
	camera.rotation.x = clampf(camera.rotation.x, view_limit_v.y, view_limit_v.x)

#Использование предмета
#по сигналу target_clicked
func action(target: Unit) -> void:
	if target:
		#применение предмета при подходящей цели
		var item: Item = storage.active_item
		if item and item.is_fit(target): item.action(self, target)
		elif target is Bench:
			var bench: Bench = target
			if not seat.is_occupied: sit_down(bench)
		else: target.interaction(self)
		interface.notice("Успешно")
	else: push_warning("Невозможно применить предмет: Цель некорректа")

#подбор дропа
func take_drop(drop: Drop) -> bool: return storage.add_item(drop.item)

#присест
func sit_down(bench: Bench) -> void:
	seat = bench
	global_position = seat.sit_pos
	view_limit_h = view_limit_v
	rotation_degrees.y = seat.rotation_degrees.y + 180 #tiso
	camera.rotation.x = seat.rotation.x
	seat.is_occupied = true
	set_captured_state(true)

#подъем
func stand_up() -> void:
	if not seat: return
	global_position = seat.stand_pos
	view_limit_h = Vector2.ZERO
	seat.is_occupied = false
	set_captured_state(false)

func run() -> void:
	if not energy > 0: speed = walk_speed; return
	if body.velocity and energy_timer.is_stopped():
		energy -= 1
		speed = run_speed
		energy_timer.start()
