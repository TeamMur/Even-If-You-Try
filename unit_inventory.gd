extends GridContainer
class_name Inventory

#Семантический доступ к хранилищу владельца
var storage: Storage:
	get(): return owner.storage

#Размер хотбара
var hotbar_size: int = 5

#Индекс активного, выделяющегося слота
var active_slot: int = -1:
	set(val):
		get_child(active_slot).texture = load(MS.tex_p.slot_hotbar)
		if val == -1 or val == active_slot: active_slot = -1
		elif val in range(0, hotbar_size):
			get_child(val).texture = load(MS.tex_p.slot_active)
			active_slot = val
		storage.active_item_index = active_slot

func set_active_slot(slot_id: int) -> void: active_slot = slot_id

#Переключатель компактного вида
var storage_visibility: bool = false:
	set(val):
		if not storage: return
		storage_visibility = val
		for i in range(hotbar_size, storage.size):
			get_child(i).visible = val

func show_storage(flag: bool) -> void: storage_visibility = flag

#Переключатель активного состояния
var is_active: bool = false:
	set(val):
		is_active = val
		set_process_input(val)
		visible = val
		storage_visibility = false
		if not visible: active_slot = -1

func set_active(flag: bool) -> void: is_active = flag

#Установка значений по умолчанию, чтобы сработали сеттеры
#Подключение сигналов хранилища
func _ready() -> void:
	is_active = false
	owner.ready.connect(connect_storage)

#Подключение сигналов хранилища к обновляющей функции
func connect_storage() -> void:
	storage.added.connect(update)
	storage.removed.connect(update)
	storage.moved.connect(update)
	update()

#Установка активного слота хотбара
#Скрытие и раскрытие основного инвентаря
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var num = event.keycode-49
		if num in range(0, hotbar_size):
			active_slot = num

#Обновление визуальной части инвентаря
func update(_item: Item = null) -> void:
	for i in range(storage.size):
		var item: Item = storage.items[i]
		var tex = null if not item else item.tex
		set_slot_texture(i, tex)

#Установка текстуры предмета определенному слоту
func set_slot_texture(slot_id: int, texture: Object) -> void:
	if slot_id == -1: return
	get_child(slot_id).get_node("ItemTexture").texture = texture

#Удаление предмета с автозаполнением похожего с конца
func remove_item(item: Item) -> void:
	var replacement: Item
	for i in range(storage.size-1, -1, -1):
		var rep: Item = storage.items[i]
		if rep and rep.name == item.name and rep != item:
			replacement = rep
			break
	#storage.remove_item(item) #навсякий
	storage.move_item(active_slot, replacement)
