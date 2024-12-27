extends Node

@onready var sleigh: RigidBody2D = $"../Sleigh"

var house = preload("res://scenes/house.tscn")

var sleighDist = 100
var houseDistMin = 200
var houseDistMax = 1200
var grid_size = 128

func _process(delta: float) -> void:
	for house in get_tree().get_nodes_in_group("buildings"):
		if house.position.distance_to(sleigh.position) > 1500:
			house.remove_from_group("buildings")
			house.queue_free()
	
	if get_tree().get_nodes_in_group("buildings").size() < 50:
		var sleighPos = spawnHouse()

func snap_to_grid(position: Vector2) -> Vector2:
	return Vector2(round(position.x / grid_size) * grid_size, round(position.y / grid_size) * grid_size)

func spawnHouse():
	while true:
		var angle = randf_range(0, 2 * PI)
		var radius = randf_range(houseDistMin, houseDistMax)

		var raw_location = Vector2(radius * cos(angle), radius * sin(angle)) + sleigh.position
		var location = snap_to_grid(raw_location)

		var buildings = get_tree().get_nodes_in_group("buildings")
		var valid_location = true

		for building in buildings:
			if building.position.distance_to(location) < houseDistMin:
				valid_location = false
				break

		if valid_location and location.distance_to(sleigh.position) > sleighDist:
			var instance = house.instantiate()
			instance.rotation_degrees = randi_range(0, 3) * 90
			instance.position = location
			instance.add_to_group("buildings")
			add_child(instance)
			return
			
	return sleigh.position


# add the target house
