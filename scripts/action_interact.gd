extends ActionData
class_name ActionInteract

func _init(performer: Unit, item: Item, target: Variant) -> void:
	super(performer, item, target)
	alias = "action_interact"
