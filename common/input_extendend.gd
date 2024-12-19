extends Node

var mouse_capture: bool = false:
	set(value):
		mouse_capture = value
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if mouse_capture else Input.MOUSE_MODE_VISIBLE

func switch_on_key(event, keycode, node, variable: String):
	#к сожалению, простого решения с исп. ссылочной переменной видимо нет
	#поэтому для ссылочной связи исп. владелец переменной
	on_key_pressed(event, keycode, node.set.bind(variable, !node.get(variable)))

func on_key_pressed(event, keycode, callable: Callable):
	if event is InputEventKey and event.keycode == keycode:
		if event.is_pressed() and not event.is_echo():
			callable.call()
