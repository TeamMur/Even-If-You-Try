extends Unit
class_name Bench

@onready var sit_marker: Marker3D = $SitMarker
@onready var stand_marker: Marker3D = $StandMarker

var is_occupied: bool = false

var sit_pos: Vector3:
	get(): return sit_marker.global_position

var stand_pos: Vector3:
	get(): return stand_marker.global_position

func _init() -> void:
	clue_text = "Сесть"
