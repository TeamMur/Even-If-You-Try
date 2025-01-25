extends RayCast3D
class_name UnitFeet

@onready var audio: AudioStreamPlayer3D = $Audio

#Возврат имени поверхности
var surface_name: String:
	get(): return get_surface_name()
	
func get_surface_name() -> String:
	var c: Object = get_collider()
	if not c: return ""
	
	
	var p: Object = c.get_parent()
	if not p is MeshInstance3D: return ""
	
	#возврат имени файла текстуры поверхности
	return p.mesh.material.albedo_texture.load_path.get_file().get_slice(".", 0)

func play_surface_sfx() -> void:
	if audio.playing: return
	var sfx: Array = MS.mus_p.get(surface_name, [])
	if not sfx: return
	var sample: String = sfx[randi()%sfx.size()]  
	audio.play_sfx(sample)
