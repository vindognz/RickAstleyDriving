extends Node

var score = 0
var time = 120

var inited = false

func _process(delta: float) -> void:
	if inited:
		$"../World/ScoreLabel".text = str(score)
		$"../World/TimeLabel".text = str(time)
