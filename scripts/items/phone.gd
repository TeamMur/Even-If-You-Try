extends Node3D

@onready var camera: Camera3D = $SubViewport/Camera
@onready var spot_light: SpotLight3D = $PSX_Nokia/SpotLight

func _input(event: InputEvent) -> void:
	if ML.is_key_just_pressed(event, KEY_F):
		print("f")
		spot_light.visible = !spot_light.visible
