extends Sprite2D

func _ready() -> void:
	randomize()
	var mat = material.duplicate()

	var random_colorA = Color(randf(), randf(), randf())
	var random_colorB = Color(randf(), randf(), randf())

	mat.set_shader_parameter("colourA", random_colorA)
	mat.set_shader_parameter("colourB", random_colorB)

	material = mat

func _process(_delta: float) -> void:
	scale.x -= 0.025
	scale.y -= 0.025
