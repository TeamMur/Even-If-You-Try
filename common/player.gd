extends CharacterBody3D
class_name Player

@onready var camera: Camera3D = $Camera
@onready var ray_cast: RayCast3D = $Camera/RayCast
@onready var interface: CanvasLayer = $Interface
@onready var clue: Label = $Interface/Clue
@onready var inventory: GridContainer = $Interface/Inventory
@onready var notificator: VBoxContainer = $Interface/Notificator

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed = 5
var jump_speed = 5
var mouse_sensitivity = 0.005

var target_object: Object
signal notify(text)
signal analyze(data)

func _ready() -> void:
	notify.connect(notice)
	analyze.connect(analysis)
	InputExtendend.mouse_capture = true

func _input(event):
	#mouse capture ~возможно стоит заменить на сброс фокуcа окна 
	InputExtendend.switch_on_key(event, KEY_ESCAPE, InputExtendend, "mouse_capture")
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT: InputExtendend.mouse_capture = true
	
	#camera rotation
	if event is InputEventMouseMotion and InputExtendend.mouse_capture: camera_rotation(event.relative)
	
	#interact
	InputExtendend.on_key_pressed(event, KEY_E, interact)

func _physics_process(delta: float) -> void:
	#movement
	movement(delta)
	
	#raycast and interactions
	vision()

func movement(delta):
	# gravity
	if not is_on_floor(): velocity += get_gravity() * delta
	
	# jump
	if Input.is_action_just_pressed("jump") and is_on_floor(): velocity.y = jump_speed
	
	# movement
	var input_dir := Input.get_vector("left", "right", "up", "down") if InputExtendend.mouse_capture else Vector2.ZERO
	
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction: #движение
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else: #плавная остановка
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		
	move_and_slide()

func camera_rotation(event_relative):
		rotate_y(-event_relative.x * mouse_sensitivity)
		camera.rotate_x(-event_relative.y * mouse_sensitivity)
		camera.rotation.x = clampf(camera.rotation.x, -deg_to_rad(70), deg_to_rad(70))

func interact():
	if target_object:
		if target_object == ray_cast.get_collider():
			var data = {"owner": self}
			target_object.get_node("InteractionModule").interact.emit(data)

func vision():
	if ray_cast.is_colliding():
		var object = ray_cast.get_collider()
		if object and object.has_node("InteractionModule"):
			target_object = object
			clue.text = object.get_node("InteractionModule").clue_text
	else:
		clue.text = ""
		target_object = null

func analysis(data):
	if "interaction_type" in data:
		match data.interaction_type:
			"pick_up": pick_up(data)
			"buff": data.effect.call(3)

func notice(text):
	var notice_label = Label.new()
	notice_label.text = text
	notice_label.add_theme_font_size_override("font_size", 32)
	notificator.add_child(notice_label)
	await get_tree().create_timer(3).timeout
	notice_label.queue_free()

func pick_up(data): inventory.add(data)
