extends Node

var Vocals = preload("res://frostbite/Voices.ogg")
var Inst = preload("res://frostbite/Inst.ogg")

func scene():
	return get_tree().get_current_scene()

func getVocal():
	return scene().get_node("AudioStreamVocals")
	
func getInst():
	return scene().get_node("AudioStreamInst")
	
func cutVocal():
	getVocal().set_volume_db(-60)
func resumeVocal():
	getVocal().set_volume_db(0.0)
	
func playState(delta):
	if !getInst().is_playing():
		getVocal().stream = Vocals
		getVocal().play()
		getInst().stream = Inst
		getInst().play()
	cutVocal()
	
