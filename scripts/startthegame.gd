extends Control

func _start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _controls_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/controls.tscn")
