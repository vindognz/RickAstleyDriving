extends Sprite2D

func _ready() -> void:
	
	# Randomizing colour of house with shaders
	var mat = material.duplicate()

	var colours = [Vector4(280, 144, 99, 255), Vector4(180, 255, 210, 255), Vector4(180,225,300,255)]
	randomize()
	var random_colour = colours[randi() % colours.size()]
	
	mat.set_shader_parameter("colour", random_colour)
	
	material = mat
	
	
	# Randomizing house shape from options
	var houseShapes = ["+", "square", "t"]
	randomize()
	var chosenShape = houseShapes[randi() % houseShapes.size()]
	texture = load("res://assets/sprites/houseShapes/" + chosenShape + ".png")
