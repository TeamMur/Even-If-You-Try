extends Node

#Запуск музыки
func _ready() -> void:
	MF.play_music(MS.mus_p.OtherSide)
	MF.play_ambient(MS.mus_p.WindInThePark)
