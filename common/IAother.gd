extends Node3D

@export var linked_object: Node

func _ready() -> void: set_process(false)

func _process(delta: float) -> void: linked_object.rotation_degrees.z += 1

#Вызывается через InteractionModule
func interaction(_data): set_process(true)
