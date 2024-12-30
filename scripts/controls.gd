extends Control

func _go_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start.tscn")
