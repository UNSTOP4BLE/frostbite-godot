extends Node2D

var pathcht = "res://frostbite/frostbite-hard.json"
var jsonData

var songTime
var songStep
var songBpm
var songSpeed

func read():
	var file = File.new()
	file.open(pathcht, File.READ)
	var json = file.get_as_text()
	jsonData  = parse_json(json)
	file.close()  
	
var step_crochet
func _ready():
	read()
	set_process_input(true) 
	songBpm = jsonData["song"]["bpm"]
	songSpeed = jsonData["song"]["speed"]
	
	var crochet = (60.0 / songBpm) * 1000.0;	
	step_crochet = crochet / 4;
	get_node("Playstate").playStateInit()

var mustHitSection
var notecount = 0
var altAnim

var pos
var type
var sus

func _process(delta):
	songTime = $AudioStreamInst.get_playback_position()
	
	songStep = int (songTime*1000 / step_crochet)
	print(songStep)
	
	if notecount >= jsonData["song"]["notes"][songStep/16]["sectionNotes"].size():
		notecount = 0
	elif songTime+2000 >= jsonData["song"]["notes"][songStep/16]["sectionNotes"][notecount][0] && jsonData["song"]["notes"][songStep/16]["sectionNotes"][notecount][1] != -1:
		pos = jsonData["song"]["notes"][songStep/16]["sectionNotes"][notecount][0]
		type = jsonData["song"]["notes"][songStep/16]["sectionNotes"][notecount][1]
		sus = jsonData["song"]["notes"][songStep/16]["sectionNotes"][notecount][2]
		notecount += 1
		
	mustHitSection = jsonData["song"]["notes"][songStep/16]["mustHitSection"]

	get_node("Playstate").playState(delta)
	
