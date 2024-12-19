extends GridContainer

var visibility_ext: bool = false:
	set(value): visibility_ext = value; show_full(value)

const HOTBAR_CELLS = 6
const MAX_CELLS = 18
var cells = []

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
		if ui_cell.visible: ui_cell.texture = cells[i].texture

func show_full(flag):
	for i in range(HOTBAR_CELLS, MAX_CELLS):
		get_child(i).visible = flag
		update()

func _input(event: InputEvent) -> void:
	InputExtendend.switch_on_key(event, KEY_TAB, self, "visibility_ext")
