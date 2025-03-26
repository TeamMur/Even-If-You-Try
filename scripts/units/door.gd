extends Unit
class_name DoorUnit

var is_locked: bool = true
var is_opened: bool = false

func _init() -> void:
	clue_text = "Заперто"
	notice_text = "Дверь заперта"

func reaction(action_data: ActionData = null) -> bool:
	if is_locked:
		var item: Item = action_data.item
		if not item or not item is ItemKey: return false
		is_locked = false
		action_data.performer.storage.remove_item(item)
		clue_text = "Открыть"
		notice_text = "Дверь разблокирована"
	else:
		if not is_opened:
			is_opened = true
			notice_text = ""
			rotation_degrees.y = 90
		elif is_opened:
			is_opened = false
			rotation_degrees.y = 0
	return true
