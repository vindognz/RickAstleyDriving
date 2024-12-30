extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/FinalScoreLabel.text += str(Global.score)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")
