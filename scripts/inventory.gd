extends GridContainer

var visibility_ext: bool = false:
	set(value): visibility_ext = value; show_full(value)

const HOTBAR_CELLS = 6
const MAX_CELLS = 18
var cells = []

var active_cell: int = -1

func _ready() -> void:
	show_full(false)

func add(data):
	if cells.size() <= MAX_CELLS:
		cells.append(data)
		update()
		var player = owner #т.к. инвентарь в сцене игрока
		player.notify.emit("Добавлен предмет %s" % data.id)

func update():
	var csz = cells.size(); var chc = get_child_count()
	for i in range(min(csz, chc)):
		var ui_cell = get_child(i)
		if ui_cell.visible: ui_cell.texture = load(cells[i].texture_path)

func show_full(flag):
	for i in range(HOTBAR_CELLS, MAX_CELLS):
		get_child(i).visible = flag
		update()

func _input(event: InputEvent) -> void:
	if ML.is_key_just_pressed(event, KEY_TAB):
		visibility_ext = !visibility_ext
	
	if event is InputEventKey and event.keycode in range(KEY_1, KEY_1 + HOTBAR_CELLS):
		ML.on_key_pressed(event, event.keycode, func():
			var player = owner
			var index = event.keycode-49
			if cells.size() >= index:
				if active_cell != index:
					player.equip(cells[index].equipment_path)
					active_cell = index
				else:
					player.equip("")
					active_cell = -1
			)
