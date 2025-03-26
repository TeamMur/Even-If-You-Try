extends Object
class_name Item

#Уникальное имя предмета
var alias: String = "name"
var action_type = ActionData
var alt_action_type = ActionInteract

#Подсказка соответсвия
var clue_text: String = "Применить"

#Установка текстуры при обращении, загрузка через словарь MS.tex_p
var texture: Texture:
	get():
		if !texture:
			var path = MS.tex_p.get(alias)
			if path: texture = load(path)
		return texture

var tex: Texture:
	get(): return texture
	
var mesh: String:
	get(): return MS.scn_p.get(alias, "")

#Проверка на подходящесть цели
func is_fit(target: Unit) -> bool:
	if not target: return false
	return false

#Потратить
func spend(storage: Variant) -> void: pass
