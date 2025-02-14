extends Unit
class_name TrashCan

func _init() -> void:
	clue_text = "Копаться в мусоре"
	notice_text = "Подобран предмет"
	storage = Storage.new()
	storage.add_item(MS.create_item("paper"), true)
	storage.add_item(MS.create_item("paper"), true)
	storage.add_item(MS.create_item("key"), true)
	storage.add_item(MS.create_item("paper"), true)
	storage.add_item(MS.create_item("paper"), true)

#костыль. Нужно создать ItemGarbage
func reaction(performer: Unit = null) -> void: interaction(performer)

#взаимодействие: передача предмета игроку и удаление
func interaction(performer: Unit = null) -> void:
	if not performer is Player: return
	var player: Player = performer
	var item: Item = storage.get_item(storage.size-1)
	if not item: return
	if player.storage.add_item(item): storage.remove_item(item, true)
	if not storage.size: notice_text = ""
