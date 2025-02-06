extends Unit
class_name Drop

#Семантический доступ к единственному предмету хранилища
var item: Item:
	get(): return storage.items[0]

func _init() -> void:
	clue_text = "Подобрать"

#Подключение сигнала при столкновении
func _ready() -> void:
	if not item: return
	var mesh: Node3D = load(item.mesh).instantiate()
	mesh.name = "Mesh"
	mesh.scale *= 0.125 #test
	add_child(mesh)

#взаимодействие: передача предмета игроку и удаление
func interaction(performer: Unit = null):
	if not performer is Player: return
	var player: Player = performer
	if player.take_drop(self): kill()
