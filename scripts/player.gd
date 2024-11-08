extends RigidBody2D

const SPEED = 5
const t = 0.1

@onready var track: Sprite2D = $"../Track"
var image: Image = null
var image_cached: bool = false

var lastRot = 0
var lastDir = Vector2.UP
var friction = 0.75

func _ready():
	if track and track.texture:
		# Cache the image once at the start
		image = track.texture.get_image()
		image_cached = true

func _process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "forward", "reverse")
	
	if Input.is_action_pressed("drift"):
		linear_damp = 0.1
		friction = 0.1
		print("DRIFT")
	else:
		friction = 2
		linear_damp = 5
			
	if direction.length() < 0.1:
		direction = lastDir
	else:
		direction = direction.normalized()
		linear_velocity += direction * SPEED
	
	if lastRot - atan2(direction.y, direction.x) > PI:
		lastRot -= 2*PI
		
	if lastRot - atan2(direction.y, direction.x) < -PI:
		lastRot += 2*PI
	
	rotation = lastRot * (1-t) + atan2(direction.y, direction.x) * t
	
	lastRot = rotation
	lastDir = direction
	
	applyFriction(direction, linear_velocity, delta)
	
	if image_cached:
		# Convert the car's global position to local coordinates relative to the track Sprite2D
		var local_pos = track.to_local(global_position)

		# Map the local position to pixel coordinates within the image
		var pixel_x = int((local_pos.x / track.texture.get_size().x) * image.get_width())
		var pixel_y = int((local_pos.y / track.texture.get_size().y) * image.get_height())

		# Check if pixel coordinates are within bounds
		if pixel_x >= 0 and pixel_x < image.get_width() and pixel_y >= 0 and pixel_y < image.get_height():
			var pixel_color = image.get_pixel(pixel_x, pixel_y)
			
			# Convert the RGBA values to 0-255 range
			var r = int(pixel_color.r * 255)
			var g = int(pixel_color.g * 255)
			var b = int(pixel_color.b * 255)
			var a = int(pixel_color.a * 255)
			
			# Print the RGBA values
			print("Pixel color at car position (RGBA 0-255):",
				"R:", r,
				"G:", g,
				"B:", b,
				"A:", a
			)

func applyFriction(direction, velocity, deltaTime):
	linear_velocity += (direction.rotated(PI / 2).dot(velocity.normalized()) * -friction * velocity.length()) * direction.rotated(PI / 2) * deltaTime # chunky boi
