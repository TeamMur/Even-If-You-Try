extends Node3D

func _process(delta: float) -> void: rotation_degrees.y += 1

#Вызывается через InteractionModule
func interaction(_data): rotation_degrees.y += 60
