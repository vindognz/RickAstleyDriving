extends RigidBody2D

const SPEED = 5

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_pressed("forward"): linear_velocity.y -= SPEED
	if Input.is_action_pressed("left"): linear_velocity.x -= SPEED
	if Input.is_action_pressed("right"): linear_velocity.x += SPEED
	if Input.is_action_pressed("reverse"): linear_velocity.y += SPEED
	
	rotation = atan2(linear_velocity.y, linear_velocity.x) + (PI/2)

# forward left right reverse
