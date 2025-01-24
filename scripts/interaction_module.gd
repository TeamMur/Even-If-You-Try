extends Node

signal interact(data)
@export var clue_text = "Подсказка"

func _ready() -> void:
	owner = get_parent() #на случай, если объект не упакован в сцену
	if owner.has_method("interaction"): interact.connect(owner.interaction)
