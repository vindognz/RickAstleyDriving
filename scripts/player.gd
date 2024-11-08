extends RigidBody2D

const SPEED = 5
const t = 0.1

var lastRot = 0
var lastDir = Vector2.UP
var friction = 0.75

func _process(delta: float) -> void:
	if $RayCast2D.is_colliding():
		print($RayCast2D.get_collider())
	var direction := Input.get_vector("left", "right", "forward", "reverse")
	
	if Input.is_action_pressed("drift"):
		linear_damp = 0.1
		friction = 0.1
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

func applyFriction(direction, velocity, deltaTime):
	linear_velocity += (direction.rotated(PI / 2).dot(velocity.normalized()) * -friction * velocity.length()) * direction.rotated(PI / 2) * deltaTime # chunky boi
