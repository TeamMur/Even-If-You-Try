extends Unit
class_name RootsUnit

func reaction(action_data: ActionData = null) -> bool:
	var item: Item = action_data.item
	if not item or not item is ItemScissors: return false
	kill()
	return true
