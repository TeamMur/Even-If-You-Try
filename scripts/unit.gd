extends Node3D
class_name Unit

#Доступ к модели при наличии
var mesh: Sprite2D:
	get():
		if not mesh and has_node("Mesh"): mesh = get_node("Mesh")
		return mesh

#Доступ к телу при наличии
var body: PhysicsBody2D:
	get():
		if not body and has_node("Body"): body = get_node("Body")
		return body

#Доступ к зоне при наличии
var area: Area2D:
	get():
		if not area and has_node("Area"): area = get_node("Area")
		return area

#Доступ к аудио при наличии
var audio: AudioStreamPlayer2D:
	get():
		if not audio and has_node("Audio"): audio = get_node("Audio")
		return audio

#Хранилище
var storage: Storage

#Реакция на воздействие
signal reacted()
func reaction() -> void:
	reacted.emit()
	kill()

#Сброс предметов
signal dropped()
func drop() -> void:
	if not storage: return
	storage.drop_all(global_position)
	dropped.emit()

#Уничтожение
signal killed()
func kill(drop: bool = false) -> void:
	if drop: drop()
	killed.emit()
	queue_free()
