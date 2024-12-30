extends Node

@onready var sleigh: RigidBody2D = $"../Sleigh"

var houseScene = preload("res://scenes/house.tscn")
var houseColours = ["gray", "red"]

func _ready() -> void:
	spawnChunk(29, Vector2(-571, -314))

func _process(_delta: float) -> void:
	for house in get_tree().get_nodes_in_group("houses"):
		if house.position.distance_to(sleigh.position) > 1500:
			house.remove_from_group("houses")
			house.queue_free()
	
	if get_tree().get_nodes_in_group("houses").size() < 50:
		spawnHouse()
	
	if get_tree().get_nodes_in_group("targetHouse").size() != 1:
		chooseTargetHouse()

func spawnHouse():
	pass

func spawnChunk(chunkSize: int, chunkPos: Vector2):
	for i in range(0, chunkSize):
		for j in range(0, chunkSize):
			if randi_range(0, 10) == 0:
				var instance = houseScene.instantiate()
				var colour = houseColours[randi_range(0, houseColours.size()-1)]
				instance.texture = load("res://assets/sprites/houses/" + colour + ".png")
				instance.rotation_degrees = randi_range(0, 3) * 90
				instance.position = chunkPos + Vector2(i, j) * 40 + Vector2(20, 20)
				instance.add_to_group("houses")
				add_child(instance)

func chooseTargetHouse():
	var possibleHouses = get_tree().get_nodes_in_group("houses")
	var targetHouse = possibleHouses[randi_range(0, possibleHouses.size()-1)]
	targetHouse.add_to_group("targetHouse")
	
	var overlaySprite = Sprite2D.new()
	targetHouse.add_child(overlaySprite)
	
	overlaySprite.texture = load("res://assets/sprites/chosenHouseOverlay.png")
