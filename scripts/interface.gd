extends CanvasLayer
class_name UnitInterface

#Доступ к элементам интерфейса
@onready var inventory: Inventory = $Margin/Margin/Inventory
@onready var inv_bg: TextureRect = $Margin/INVbg

#Доступ к уведомлятору
@onready var notificator: VBoxContainer = $Notificator

#Доступ к подсказке
@onready var clue: Label = $Clue

#Доступ к курсору
@onready var cursor: Control = $Cursor

#Шкала энергии
@onready var energy_bar: ProgressBar = $EnergyBar

#Переключатель активного состояния
var is_active: bool = false:
	set(val):
		is_active = val
		inventory.set_active(val)

func set_active(flag: bool) -> void: is_active = flag

#Переключатель компактного вида
var short_view: bool = false: 
	set(val):
		short_view = val
		inventory.storage_visibility = val
		
		var bg = load(MS.tex_p.inv_bg_full) if val else load(MS.tex_p.inv_bg_short)
		inv_bg.texture = bg
		

func set_short_view(flag: bool) -> void: short_view = flag

#Установка значений по умолчанию
func _ready() -> void:
	inv_bg.texture = load(MS.tex_p.inv_bg_short)
	clue.text = ""

#Переключение компактного вида
func _input(event: InputEvent) -> void:
	if ML.is_key_just_pressed(event, KEY_TAB):
		short_view = !short_view

func notice(text) -> void:
	if not text: return
	if not is_active: return
	var notice_label = Label.new()
	notice_label.text = text
	notice_label.add_theme_font_size_override("font_size", 32)
	notificator.add_child(notice_label)
	await get_tree().create_timer(3).timeout
	notice_label.queue_free()
