extends Node

var data = {"popa": true}

func _ready() -> void:
	print(data.pisa) #так не работает
	
	data.pisa = false
	print(data.pisa) #так работает
