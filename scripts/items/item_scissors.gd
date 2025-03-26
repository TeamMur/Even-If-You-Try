extends ItemTool
class_name ItemScissors

func _init() -> void:
	clue_text = "Резать"
	
func is_fit(target: Unit): return target is RootsUnit
