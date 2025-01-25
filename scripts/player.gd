extends Unit
class_name Player

#Ноги, определяющие поверхность
var feet: UnitFeet:
	get():
		if not feet and has_node("Feet"): feet = get_node("Feet")
		return feet

#Камера. Отдельный скрипт не нужен, т.к. игрок один единственный
@onready var camera: Camera3D = $Camera

#Скорость движения
var speed: int = 5

var gravity: float = MG.gravity

#Скорость прыжка
var jump_force: int = 5

#Определение игрока
func _ready() -> void:
	MG.set_player(self)

#звук шагов
func _process(_delta: float) -> void:
	if body.dir and body.is_on_floor(): feet.play_surface_sfx()
	else: if feet.audio.playing: feet.audio.stop()

#Определение направления инпута
#и передача его телу
#а также поворот камеры
func _input(event: InputEvent) -> void:
	#поворот камеры
	if event is InputEventMouseMotion and ML.mouse_capture:
		camera_rotation(event)
	#направление
	var input_dir: Vector2 = Input.get_vector("left", "right", "up", "down") if ML.mouse_capture else Vector2.ZERO
	#тело
	body.dir = input_dir
	#прыжок
	if Input.is_action_just_pressed("jump"): body.jump()

#Расчет поворота камеры на основе входящего события
func camera_rotation(event: InputEventMouseMotion):
		rotate_y(-event.relative.x * ML.sens)
		camera.rotate_x(-event.relative.y * ML.sens)
		camera.rotation.x = clampf(camera.rotation.x, -deg_to_rad(70), deg_to_rad(70))
