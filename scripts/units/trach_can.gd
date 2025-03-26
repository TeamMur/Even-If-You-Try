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

func reaction(action_data: ActionData = null) -> bool:
	if not action_data.performer is Player: return false
	var player: Player = action_data.performer
	var item: Item = storage.get_item(storage.size-1)
	if not item: return false
	if player.storage.add_item(item): storage.remove_item(item, true)
	if not storage.size: notice_text = ""
	return true
