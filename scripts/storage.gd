extends Node
class_name Storage
#NOTE: Все операции хранилище выполняет над ячеками массива, а не над содержимым

#Массив предметов
var items: Array

#Семантический доступ к размеру массива
var size: int:
	get(): return items.size()

#Активный предмет, расчитываемый на основе индекса
var active_item: Item = null:
	get():
		if active_item_index != -1: return items[active_item_index]
		else: return null

#Индекс активного предмета
var active_item_index: int 

#Добавление предмета
signal added(item: Item)
func add_item(item: Item, append: bool = false) -> bool:
	#проверяет размер массива
	if not items:
		if append: items.append(item); return true
		else: return false
	
	#проверяет пустость массива
	if not null in items:
		if append: items.append(item); return true
		else: return false
	
	var index: int = items.find(null)
	items[index] = item
	added.emit(item)
	return true

#Дроп предметов c очисткой ячейки
signal dropped(item: Item)
func drop_all(pos: Vector3) -> bool:
	if not items: return false
	
	for item in items:
		if item:
			MG.spawn_drop(pos, item)
			remove_item(item)
			dropped.emit(item)
	return true

#Очистка ячейки
signal removed(item: Item)
func remove_item(item) -> void:
	var index: int = items.find(item)
	items[index] = null
	removed.emit(item)

#Изменение размера
func resize(size) -> void:
	items.resize(size)

#Проверка наличия предмета
func has(item: Item) -> bool:
	return items.has(item)

#Перемещение предмета
signal moved(item: Item)
func move_item(index: int, item: Item) -> void:
	remove_item(item)
	items[index] = item
	moved.emit(item)
