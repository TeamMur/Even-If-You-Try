extends CanvasLayer

@onready var info_label: Label = $Info

@onready var window: Window = get_window()

func _input(event: InputEvent) -> void:
	#visibility switcher
	InputExtendend.on_key_pressed(event, KEY_F3, func(): visible = !visible; set_process(visible))

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
	info_label.text = result_string
