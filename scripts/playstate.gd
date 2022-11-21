extends Node

var Vocals = preload("res://frostbite/Voices.ogg")
var Inst = preload("res://frostbite/Inst.ogg")

func scene():
	return get_tree().get_current_scene()

func getVocal():
	return scene().get_node("AudioStreamVocals")
	
func getInst():
	return scene().get_node("AudioStreamInst")
	
# game functions
func cutVocal():
	getVocal().set_volume_db(-60)
func resumeVocal():
	getVocal().set_volume_db(0.0)
	
# player functions
func Gold_SetAnim(var anim):
	$Gold.get_node("AnimationPlayer").set_current_animation(anim)	
	$Gold.get_node("AnimationPlayer").play()
	
		

# game functions
func playStateInit():
	getVocal().stream = Vocals
	getVocal().play()
	getInst().stream = Inst
	getInst().play()
	
	$Gold.get_node("AnimationPlayer").set_speed_scale(30)
	Gold_SetAnim("gold-idle")

var bump = false;
var checkInput = [0, 0, 0, 0];

func playState(delta):
	bump = scene().songStep % 8 == 7
	
	checkInput[0] = Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT)
	checkInput[1] = Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN)
	checkInput[2] = Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP)
	checkInput[3] = Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT)
	
	# Player animation
	if checkInput[0]:
		Gold_SetAnim("gold-left")
	elif checkInput[1]:
		Gold_SetAnim("gold-down")
	elif checkInput[2]:
		Gold_SetAnim("gold-up")
	elif checkInput[3]:
		Gold_SetAnim("gold-right")
	elif bump:
		Gold_SetAnim("gold-idle")
