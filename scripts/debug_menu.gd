extends CanvasLayer
class_name DebugMenu

#Текстовая табличка
@onready var info_label: Label = $Info

var is_active: bool = false:
	set(val):
		is_active = val
		visible = val
		set_process(val)

#Переключение видимости
func _input(event: InputEvent) -> void:
	if ML.is_key_just_pressed(event, KEY_F3): is_active = !is_active

#Определение переменных для срабатывания сеттеров
func _ready() -> void: is_active = false
func _process(delta: float) -> void: update()

#Обновление дебажной информации
func update() -> void:
	# FPS
	var fps: String = "FPS: %s" % Engine.get_frames_per_second()
	
	# WINDOW
	var window: Window = get_window()
	var win_size: String = "Window size: %d×%d" % [window.size.x, window.size.y]
	var win_pos: String = "Window pos: %d×%d" % [window.position.x, window.position.y]
	
	# SCREEN
	var screen_size: Vector2i = DisplayServer.screen_get_size()
	var scr_id: String = "Screen id: %d" % DisplayServer.window_get_current_screen()
	var scr_size: String = "Screen size: %d×%d" % [screen_size.x, screen_size.y]
	
	# RESULT
	var result_string: String
	var all_info: Array = [fps, win_pos, win_size, scr_size, scr_id]
	for info in all_info: result_string += " " + info + "\n"
	info_label.text = result_string
