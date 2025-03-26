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
signal active_index_changed()
var active_item_index: int:
	set(val):
		if active_item_index != val:
			active_item_index = val
			active_index_changed.emit()

signal updated()
func _init(size: int = 0, items: Variant = null) -> void:
	if size:
		self.items.resize(size)
	if items:
		if items is Item: add_item(items, true)
		elif items is Array[Item]: for item in items: add_item(item, true)
		elif items is String:
			var item_array: Array[Item]
			if items is String:
				var split: Array = items.split("/")
				for alias: String in split: add_item(MS.create_item(alias), true)
			else: item_array = items
	var upd: Callable = func(_arg): updated.emit()
	added.connect(upd)
	removed.connect(upd)
	moved.connect(upd)
	inserted.connect(upd)

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
func remove_item(item, resize = false) -> void: #new: resize
	var index: int = items.find(item)
	items[index] = null
	removed.emit(item)
	if index+1 == size and resize: resize(index)

func get_item(index: int) -> Item: #new
	if index < 0: return null
	return items[index]

#Изменение размера
func resize(size) -> void:
	items.resize(size)

#Проверка наличия предмета
func has(item: Item) -> bool:
	return items.has(item)

signal inserted(item: Item)
func insert_item(index: int, item: Item):
	items[index] = item
	inserted.emit(item)

#Перемещение предмета
signal moved(item: Item)
func move_item(index: int, item: Item) -> void:
	remove_item(item)
	items[index] = item
	moved.emit(item)
