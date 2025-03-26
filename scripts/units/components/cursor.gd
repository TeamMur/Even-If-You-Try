extends Control

func _draw():
	var r: float = 4
	draw_rect(Rect2(r-r/2, r-r/2, r, r), Color.WHITE)
	draw_rect(Rect2(r-r/2, r-r/2, r, r), Color.BLACK, false)
