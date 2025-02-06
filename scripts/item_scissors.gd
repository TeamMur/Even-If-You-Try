extends ItemTool
class_name ItemScissors

func _init() -> void: clue_text = "Резать"
func is_fit(target: Unit): return target is RootsUnit
func action(_performer: Unit, target: Variant) -> void: target.reaction()
