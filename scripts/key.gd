extends HSlider

@onready var key: ColorRect = $"../bg/ColorRect"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	key.rotation_degrees = self.value * 90
