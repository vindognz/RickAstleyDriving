extends RigidBody2D

var presentScene = preload("res://scenes/present.tscn")

const SPEED = 2
const MAXt = 0.25

var t = 0.1
var lastRot = 0
var lastDir = Vector2.RIGHT
var friction = 1

var presentDropping = false

func _process(delta: float) -> void:
	
	var direction := Input.get_vector("left", "right", "forward", "reverse")
	
	if Input.is_action_just_pressed("drop-present") and not presentDropping:
		presentDropping = true
		
		dropAPresent()
	
	if presentDropping:
		var thePresent = get_tree().get_nodes_in_group("present")[0]
		
		if thePresent.scale.x <= 0.5:
			presentDropping = false
			thePresent.remove_from_group("present")
			
			var targetHouseDist = getTargetHouseDist(thePresent)
			
			if targetHouseDist < 30:
				Global.score += round(10/max(targetHouseDist, 0.75)**3)
				get_tree().get_nodes_in_group("targetHouse")[0].queue_free()
				
			thePresent.queue_free()
	
		
	if position.distance_to(get_tree().get_nodes_in_group("targetHouse")[0].position) < 50:
		Engine.time_scale = 0.75
	else:
		Engine.time_scale = 1
		
	if direction.length() < 0.1:
		direction = lastDir
	
	direction = direction.normalized()
	apply_force(direction*SPEED/mass)
	
	if lastRot - atan2(direction.y, direction.x) > PI:
		lastRot -= 2*PI
		
	if lastRot - atan2(direction.y, direction.x) < -PI:
		lastRot += 2*PI

	t = min(linear_velocity.length() / 250, 1) * MAXt
	rotation = lastRot * (1-t) + atan2(direction.y, direction.x) * t
	
	lastRot = rotation
	lastDir = direction
	
	applyFriction(direction, linear_velocity, delta)
	
	pointToTarget()

func applyFriction(direction, velocity, deltaTime):
	apply_force(((direction.rotated(PI / 2).dot(velocity.normalized()) * -friction * velocity.length()) * direction.rotated(PI / 2) * deltaTime)/mass)

func dropAPresent():
	var presentInstance = presentScene.instantiate()
	$BackMarker.add_child(presentInstance)
	presentInstance.add_to_group("present")
	await get_tree().create_timer(0.05).timeout
	presentInstance.reparent($"..")

func getTargetHouseDist(present):
	var targetHouse = get_tree().get_nodes_in_group("targetHouse")[0]
	var pxDistance = present.position.distance_to(targetHouse.position)
	return pxDistance/10

func pointToTarget():
	var targetHouse = get_tree().get_nodes_in_group("targetHouse")[0]
	$Marker2D.rotation = transform.looking_at(targetHouse.global_position).get_rotation()
	$Marker2D.rotation -= rotation

	$Marker2D/Sprite2D/Label.rotation = -$Marker2D.rotation - rotation
	
	$Marker2D/Sprite2D/Label.text = str(round(targetHouse.position.distance_to(position)/10))
