extends ProgressBar

func _ready() -> void:
	var player: Player = owner
	max_value = player.max_energy
	value = player.energy
	player.energy_changed.connect(func(): value = player.energy)
