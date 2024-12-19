extends Node3D

#Вызывается через InteractionModule
func interaction(data):
	if data and data.owner is Player:
		var player = data.owner
		var effect = func(multiply = 5):
			var original_speed = player.speed
			player.speed = original_speed*multiply
			await get_tree().create_timer(3).timeout
			player.speed = original_speed
		var self_data = {
			"owner": self,
			"interaction_type": "buff",
			"effect": effect
			}
		player.analyze.emit(self_data)
