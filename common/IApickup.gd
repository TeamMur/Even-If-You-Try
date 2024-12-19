extends StaticBody3D

@export var item_id: String = "id"
@export var item_texture: Texture = null

#Вызывается через InteractionModule
func interaction(data):
	if data and data.owner is Player:
		var player = data.owner
		var self_data = {
			"owner": self,
			"interaction_type": "pick_up",
			"id": item_id,
			"texture": item_texture
			}
		player.analyze.emit(self_data)
		#queue_free()
