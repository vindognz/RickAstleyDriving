extends Label

var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 60
	timer.start()
	
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))

func _process(_delta: float) -> void:
	var minutes = int(timer.time_left) / 60
	var seconds = int(timer.time_left) % 60
	text = str(minutes) + ":" + str(seconds).pad_zeros(2)

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
