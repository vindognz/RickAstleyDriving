extends Label

func _ready() -> void:
	Global.score = 0
	text = "Score: " + str(0)

func _process(_delta: float) -> void:
	text = "Score: " + str(Global.score)
