extends Node

@onready var key: ColorRect = $Key/ColorRect
@onready var slider: HSlider = $HSlider
@onready var countdown: Label = $Countdown

var wasTrue = false

func _process(_delta: float) -> void:
	key.rotation_degrees = slider.value * 90
	
	if slider.value == 1 and not wasTrue:
		wasTrue = true
		slider.editable = false
		countdown.text = "3"
		await get_tree().create_timer(1).timeout
		countdown.text = "2"
		await get_tree().create_timer(1).timeout
		countdown.text = "1"
		await get_tree().create_timer(1).timeout
		
		get_tree().change_scene_to_file("res://scenes/car.tscn")
