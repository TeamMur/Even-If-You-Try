extends Object
class_name Item

#Уникальное имя предмета
var name: String = "name"

#Подсказка соответсвия
var clue_text: String = "Применить"

#Установка текстуры при обращении, загрузка через словарь MS.tex_p
var texture: Texture:
	get():
		if !texture:
			var path = MS.tex_p.get(name)
			if path: texture = load(path)
		return texture

var tex: Texture:
	get(): return texture
	
var mesh: String:
	get(): return MS.scn_p.get(name)

#Проверка на подходящесть цели
func is_fit(target: Unit) -> bool: return not target is Player

#Действие. TBD target пока осознанно без класса
func action(_performer: Unit, _target: Variant) -> void: print("action")
