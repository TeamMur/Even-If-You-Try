extends CharacterBody3D

@onready var ray_cast: RayCast3D = $Camera/RayCast
@onready var interface: CanvasLayer = $Interface
@onready var clue: Label = $Interface/Clue
@onready var inventory: GridContainer = $Interface/Inventory
@onready var notificator: VBoxContainer = $Interface/Notificator
@onready var hand: Node3D = $Camera/Hand
@onready var collision: CollisionShape3D = $Collision

var target_object: Object
signal notify(text)
signal analyze(data)

func _ready() -> void:
	notify.connect(notice)
	analyze.connect(analysis)

func _input(event):
	#interact
	if ML.is_key_just_pressed(event, KEY_E): interact()

func _physics_process(delta: float) -> void:
	#raycast and interactions
	vision()

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

func equip(scene_path):
	if hand.get_child_count() > 0: hand.get_child(0).queue_free()
	if scene_path:
		var equipment = load(scene_path).instantiate()
		hand.add_child(equipment)

func pick_up(data): inventory.add(data)
