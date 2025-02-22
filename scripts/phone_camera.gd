extends Camera3D

func _process(delta: float) -> void:
	var phone = owner
	global_transform = phone.owner.camera.global_transform
