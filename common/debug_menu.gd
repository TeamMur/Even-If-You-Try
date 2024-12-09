extends CanvasLayer

@onready var label: Label = $Label

@onready var window: Window = get_window()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_F3:
		if event.is_pressed() and not event.is_echo():
			visible = !visible
			set_process(visible)

func _process(delta: float) -> void:
	# FPS
	var fps = "FPS: %s" % Engine.get_frames_per_second()
	
	# WINDOW
	var win_size = "Window size: %d×%d" % [window.size.x, window.size.y]
	var win_pos = "Window pos: %d×%d" % [window.position.x, window.position.y]
	
	# SCREEN
	var screen_size = DisplayServer.screen_get_size()
	var scr_id = "Screen id: %d" % DisplayServer.window_get_current_screen()
	var scr_size = "Screen size: %d×%d" % [screen_size.x, screen_size.y]
	
	# RESULT
	var result_string: String
	var all_info = [fps, win_pos, win_size, scr_size, scr_id]
	for info in all_info: result_string += " " + info + "\n"
	label.text = result_string
