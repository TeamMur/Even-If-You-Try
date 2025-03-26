extends Node
class_name MasterOfTheGame

#Доступ к миру
var world: Node3D
func set_world(val) -> void: world = val

#Доступ к игроку
var player: Player
func set_player(val) -> void: player = val

#Скорость падения объектов
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

#Порождение дропа
func spawn_drop(pos: Vector3, item: Item) -> Drop:
	var drop: Drop = load("res://scenes/drop.tscn").instantiate()
	drop.storage = Storage.new()
	drop.storage.add_item(item, true)
	world.add_child(drop)
	drop.global_position = pos
	return drop

#Порождение объекта
func spawn_object(pos: Vector3, path: String) -> Unit:
	var object = load(path).instantiate()
	object.global_position = pos
	world.add_child(object)
	return object
