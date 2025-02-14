extends Camera3D

func _process(delta: float) -> void:
	global_transform = owner.camera.global_transform
