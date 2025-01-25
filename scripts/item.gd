extends Object
class_name Item

#Уникальное имя предмета
var name: String = "name"

#Максимальная дистанция использования
var max_range: int = 2

#Установка текстуры при обращении, загрузка через словарь MS.tex_p
var texture: Texture:
	get():
		if !texture:
			var path = MS.tex_p.get(name)
			if path: texture = load(path)
		return texture

var tex: Texture:
	get(): return texture

#Семантический доступ к классу предмета через словарь MS.cls_p
var cls: Object:
	get(): return MS.cls_p.get(name)

#Проверка на подходящесть цели
func is_fit(target: Unit) -> bool: return not target is Player

#Действие. TBD target пока осознанно без класса
func action(_target) -> void: print("action")

#Инструмент
class Tool extends Item:
	func _init() -> void: max_range = 3
	func action(_target: Unit) -> void: print("есть пробитие")

#Материал
class Stuff extends Item: pass
