extends Node
class_name MasterOfTheSenses

#Проигрыватели
@onready var sfx: AudioStreamPlayer = $SFX
@onready var music: AudioStreamPlayer = $MUSIC
@onready var ambient: AudioStreamPlayer = $AMBIENT

#Проигрывание музыки по заданному пути
func play_music(path: String):
	var stream: Object = load(path)
	music.stream = stream
	music.play()

#Проигрывание эмбиента по заданному пути
func play_ambient(path: String):
	var stream: Object = load(path)
	ambient.stream = stream
	ambient.play()

#Проигрывание звука
#создает самоудаляющуюся копию нода,
#если несколько звуков звучат одновременно
func play_sfx(path: String):
	var stream: Object = load(path)
	if sfx.stream != stream:
		sfx.stream = stream
		sfx.play()
	else:
		var sfx_prim: AudioStreamPlayer = sfx.duplicate()
		sfx_prim.stream = stream
		sfx_prim.autoplay = true
		
		var sfx_kill: Callable = func() -> void: sfx_prim.queue_free()
		sfx_prim.finished.connect(sfx_kill)
		
		add_child(sfx_prim)
