extends Node

#Запуск музыки
#установка фокуса
func _ready() -> void:
	ML.mouse_capture = true
	
	MF.play_music(MS.mus_p.OtherSide)
	MF.play_ambient(MS.mus_p.WindInThePark)

#Переключение фокуса
func _input(event: InputEvent) -> void:
	if ML.is_key_just_pressed(event, KEY_ESCAPE):
		ML.mouse_capture = !ML.mouse_capture
	
	if ML.is_mouse_pressed(event, MOUSE_BUTTON_LEFT):
		ML.mouse_capture = true
