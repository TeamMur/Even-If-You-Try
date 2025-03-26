extends Node2D
class_name MasterOfTheLogic

#Чувствительность мыши
var mouse_sensitivity: float = 0.005
var sens: float:
	get(): return mouse_sensitivity

#Сигнал Клик по цели с информацией о событии
signal target_clicked(event: InputEvent, target)

#Проверка события event на соответсвие простому клику
func is_just_pressed(event: InputEvent) -> bool:
	return event.is_pressed() and not event.is_echo() 

#Проверка события event на соответсвие нажатию клавиши keycode 
func is_key_just_pressed(event: InputEvent, keycode: int) -> bool:
	return event is InputEventKey and event.keycode == keycode and event.is_pressed() and not event.is_echo() 

#Проверка события event на соответсвие нажатию клавиши мыши button_index 
func is_mouse_pressed(event: InputEvent, button_index: int) -> bool:
	return event is InputEventMouseButton and event.button_index == button_index and event.is_pressed()

#Проверка события event на соответсвие отпускание клавиши мыши button_index
func is_mouse_released(event: InputEvent, button_index: int) -> bool:
	return event is InputEventMouseButton and event.button_index == button_index and event.is_released()

#Проверка события event на соответсвие колесику мыши
func is_mouse_wheel(event: InputEvent) -> bool:
	return event is InputEventMouseButton and event.button_index in [MOUSE_BUTTON_WHEEL_UP, MOUSE_BUTTON_WHEEL_DOWN]

#Проверка события event на движение мыши с определенной зажатой кнопкой
func is_mouse_motion(event: InputEvent, button_mask: int = 0) -> bool:
	return event is InputEventMouseMotion and event.button_mask == button_mask

#Захват мыши
var mouse_capture: bool = false:
	set(value):
		mouse_capture = value
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if mouse_capture else Input.MOUSE_MODE_VISIBLE

#Переключение фокуса
func _input(event: InputEvent) -> void:
	if is_key_just_pressed(event, KEY_ESCAPE): mouse_capture = !ML.mouse_capture
	if is_mouse_pressed(event, MOUSE_BUTTON_LEFT): mouse_capture = true
