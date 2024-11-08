extends Node

@onready var key: ColorRect = $Key/ColorRect
@onready var slider: HSlider = $HSlider
@onready var transition: Control = $TransitionManager

@onready var animationPlayer = transition.get_node("AnimationPlayer")

var was1 = false

func _process(delta: float) -> void:
	key.rotation_degrees = slider.value * 90
	
	if slider.value == 1 and not was1:
		animationPlayer.play("fade_out")
		was1 = true
		await animationPlayer.animation_finished
		get_tree().change_scene_to_file("res://scenes/car.tscn")
	
	if slider.value != 1 and was1:
		animationPlayer.play("fade_in")
		await animationPlayer.animation_finished
		was1 = false

func _ready():
	transition.visible = true
