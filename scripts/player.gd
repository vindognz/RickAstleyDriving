extends RigidBody2D

const SPEED = 10
const MAXt = 0.1

var t = 0.1
var lastRot = 0
var lastDir = Vector2.RIGHT
var friction = 2

func _process(delta: float) -> void:
	
	var direction := Input.get_vector("left", "right", "forward", "reverse")
	
	if Input.is_action_pressed("drift"):
		friction = 0.5
		linear_damp = 1
	else:
		friction = 2
		linear_damp = 5
		
	if direction.length() < 0.1:
		direction = lastDir
	
		direction = direction.normalized()
		
		apply_force(direction*SPEED/mass)
	
	if lastRot - atan2(direction.y, direction.x) > PI:
		lastRot -= 2*PI
		
	if lastRot - atan2(direction.y, direction.x) < -PI:
		lastRot += 2*PI

	t = min(linear_velocity.length() / 500, 1) * MAXt
	rotation = lastRot * (1-t) + atan2(direction.y, direction.x) * t
	
	lastRot = rotation
	lastDir = direction
	
	applyFriction(direction, linear_velocity, delta)

func applyFriction(direction, velocity, deltaTime):
	apply_force(((direction.rotated(PI / 2).dot(velocity.normalized()) * -friction * velocity.length()) * direction.rotated(PI / 2) * deltaTime)/mass)
