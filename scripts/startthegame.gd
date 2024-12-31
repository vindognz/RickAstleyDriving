extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _start_pressed() -> void:
	animation_player.play("start_game")

func _controls_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/controls.tscn")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")
