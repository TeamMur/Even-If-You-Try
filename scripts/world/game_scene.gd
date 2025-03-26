extends Node

#Запуск музыки
#установка фокуса
func _ready() -> void:
	ML.mouse_capture = true
	
	MF.play_music(MS.mus_p.OtherSide)
	MF.play_ambient(MS.mus_p.WindInThePark)
	
	var player: Player = get_node("World/Player")
	player.storage.add_item(MS.create_item("scissors"))
	player.storage.add_item(MS.create_item("phone"))
	var bench: Bench = get_node("World/Bench")
	player.sit_down(bench)
