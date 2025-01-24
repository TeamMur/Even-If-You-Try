extends AudioStreamPlayer3D
class_name UnitAudio

#Проигрывает звук, заменяя проигрываемый
func play_sfx(path: String):
	var stream: Object = load(path)
	if stream != self.stream:
		self.stream = stream
		play()
