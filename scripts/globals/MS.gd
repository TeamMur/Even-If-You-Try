extends Node
class_name MasterOfTheSaves

#Пакет текстур
var texture_pack: Dictionary
var tex_p: Dictionary:
	get(): return texture_pack

#Пакет классов
var class_pack: Dictionary
var cls_p: Dictionary:
	get(): return class_pack

#Пакет сцен
var scene_pack: Dictionary
var scn_p: Dictionary:
	get(): return scene_pack

#Пакет музыки
var music_pack: Dictionary
var mus_p: Dictionary:
	get(): return music_pack

#Инициализация
func _init() -> void:
	music_pack = default_music
	texture_pack = default_textures
	class_pack = default_classes
	scene_pack = default_scenes

#Дефолтный пакет музыки
var default_music: Dictionary = {
	#music
	"OtherSide": "res://assets/audio/OtherSide_Music.mp3",
	
	#ambient
	"WindInThePark": "res://assets/audio/WindInThePark_AMBIENT.mp3",
	
	#surface
	"black": [ #temp
		"res://assets/audio/GrassStep1_Sound.mp3",
		"res://assets/audio/GrassStep2_Sound.mp3",
		"res://assets/audio/GrassStep3_Sound.mp3",
		"res://assets/audio/GrassStep4_Sound.mp3",
		"res://assets/audio/GrassStep5_Sound.mp3"
	],
	"white": [ #temp
		"res://assets/audio/SandRoadStep1_Sound.mp3",
		"res://assets/audio/SandRoadStep2_Sound.mp3",
		"res://assets/audio/SandRoadStep3_Sound.mp3",
		"res://assets/audio/SandRoadStep4_Sound.mp3",
		"res://assets/audio/SandRoadStep5_Sound.mp3"
	],
	
	"grass": [
		"res://assets/audio/GrassStep1_Sound.mp3",
		"res://assets/audio/GrassStep2_Sound.mp3",
		"res://assets/audio/GrassStep3_Sound.mp3",
		"res://assets/audio/GrassStep4_Sound.mp3",
		"res://assets/audio/GrassStep5_Sound.mp3"
	],
	
	"sand": [
		"res://assets/audio/SandRoadStep1_Sound.mp3",
		"res://assets/audio/SandRoadStep2_Sound.mp3",
		"res://assets/audio/SandRoadStep3_Sound.mp3",
		"res://assets/audio/SandRoadStep4_Sound.mp3",
		"res://assets/audio/SandRoadStep5_Sound.mp3"
	],
}

#Дефолтный пакет текстур
var default_textures: Dictionary = {
	#item
	"scissors": "res://assets/textures/ITM_WireCuttersSturdy_01.tex.png",
	"bush": "res://assets/textures/models/bush_square_0.png",
	"paper": "res://assets/textures/CRFT_PaperMache_002.tex.png",
	"key": "res://assets/textures/ITM_Key_Emerald_002.tex.png",
	"phone": "res://assets/textures/free-png.ru-694-370x230.png",
	
	#ui
	"slot_hotbar":  "res://assets/textures/slot0.png",
	"slot_storage": "res://assets/textures/slot0.png",
	"slot_active":  "res://assets/textures/slot1.png",
	
	"inv_bg_full": "res://assets/textures/inv_bg.png",
	"inv_bg_short": "res://assets/textures/inv_bg0.png"
}

#Дефолтный пакет классов
var default_classes: Dictionary = {
	"name":         Object,
	
	"bush": Item,
	"paper": Item,
	"key": ItemKey,
	
	"scissors": ItemScissors,
	"phone":    ItemPhone
}

#Дефолтный пакет сцен
var default_scenes: Dictionary = {
	"name": "scene/path",
	
	#meshes
	"bush": "res://assets/models/bush_square.glb",
	
	#items
	"key": "res://scenes/items/key.tscn",
	"phone": "res://scenes/items/phone.tscn",
	"paper": "res://scenes/items/paper.tscn",
	"scissors": "res://scenes/items/scissors.tscn"
}

#Создание предмета на основе имени
#основная задача - определение класса и текстуры
func create_item(alias: String) -> Item:
	if not cls_p.has(alias): push_warning("Несуществующий предмет"); return
	var cls: Object = cls_p.get(alias)
	var item: Item = cls.new()
	item.alias = alias
	return item
