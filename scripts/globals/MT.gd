extends CanvasLayer
class_name DebugMenu

var alias: String = "master_of_the_tests"

@onready var info_label: Label = $Info

func _input(event: InputEvent) -> void:
	if ML.is_key_just_pressed(event, KEY_F3): info_label.visible = !info_label.visible

func _ready() -> void: info_label.visible = false
func _process(_delta: float) -> void: update()

func update() -> void:
	var fps: String = "FPS: %d" % Engine.get_frames_per_second()
	info_label.text = fps
