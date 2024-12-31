extends ColorRect

func _ready() -> void:
	$AnimationPlayer.play("fade_in")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
