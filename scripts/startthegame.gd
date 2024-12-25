extends Node

@onready var animation_player: AnimationPlayer = $Snow/AnimationPlayer

func _on_button_pressed() -> void:
	animation_player.play("start-game")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://scenes/car.tscn")
