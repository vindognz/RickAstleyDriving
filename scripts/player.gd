extends RigidBody2D

const SPEED = 5
const t = 0.1

var lastRot = 0
var lastDir = Vector2.UP

func _process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "forward", "reverse")
	
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
# forward left right reverse
