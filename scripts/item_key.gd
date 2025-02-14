extends Item
class_name ItemKey

func is_fit(target: Unit) -> bool: return target is DoorUnit

func action(performer: Unit, target: Variant) -> void:
	if not is_fit(target): return
	var door: DoorUnit = target
	door.reaction(performer)
