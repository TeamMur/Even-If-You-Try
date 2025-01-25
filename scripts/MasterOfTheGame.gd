extends Node
class_name MasterOfTheGame

#Доступ к миру
var world: Node3D
func set_world(val): world = val

#Доступ к игроку
var player: Player
func set_player(val): player = val

#Скорость падения объектов
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#Порождение объекта
func spawn_object(pos: Vector3, path: String) -> Unit:
	var object = load(path).instantiate()
	object.global_position = pos
	world.add_child(object)
	return object
