extends Node2D

var pathcht = "res://frostbite/frostbite-hard.json"
var jsonData

var songTime
var songStep
var songBpm

func read():
	var file = File.new()
	file.open(pathcht, File.READ)
	var json = file.get_as_text()
	jsonData  = parse_json(json)
	file.close()  
	
var step_crochet
func _ready():
	read()
	songBpm = jsonData["song"]["bpm"]
	
	var crochet = (60.0 / songBpm) * 1000.0;	
	step_crochet = crochet / 4;

func _process(delta):
	songTime = $AudioStreamInst.get_playback_position()
	
	songStep = int (songTime / int(step_crochet))
	print(songStep)
	get_node("Playstate").playState(delta)
	
