extends Unit
class_name DoorUnit

var is_locked: bool = true
var is_opened: bool = false

func _init() -> void:
	clue_text = "Заперто"
	notice_text = "Дверь заперта"

func reaction(performer: Unit = null) -> void:
	if performer is Player:
		var player = performer
		var item: Item = player.storage.active_item
		if item and item.name == "key":
			is_locked = false
			player.storage.remove_item(item)
			clue_text = "Открыть"
			notice_text = "Дверь разблокирована"

func interaction(_performer: Unit) -> void:
	if not is_locked and not is_opened:
		is_opened = true
		notice_text = ""
		rotation_degrees.y = 90
	elif is_opened:
		is_opened = false
		rotation_degrees.y = 0
