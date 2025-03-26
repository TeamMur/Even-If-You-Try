extends Node
class_name ActionData

var alias: String = "action_data"

var performer: Unit
var item: Item
var target: Variant

func _init(performer: Unit = null, item: Item = null, target: Variant = null) -> void:
	self.performer = performer
	self.item = item
	self.target = target
