extends Node

var straightTile = preload("res://scenes/straightTile.tscn")
var cornerTile = preload("res://scenes/cornerTile.tscn")

var newestBranch
var batchNum = 0
var corner = 50
var lastCornerRight = false
var parentList = []

@onready var car: Node2D = $Car

func _ready():
	genBatch(10)

func _process(delta: float) -> void:
	if newestBranch != null:
		if (newestBranch.global_position - car.transform.origin).length() < 1500:
			batchNum += 1
			genBatch(5)
			
			if batchNum > 5:
				parentList.pop_back().queue_free()

func newTile(parent):
	if newestBranch == null:
		var tile = straightTile.instantiate()
		parent.add_child.call_deferred(tile)
		tile.global_position = car.global_position
		newestBranch = tile.get_child(0).get_child(0)
	else:
		if randi_range(1, 50) > corner:
			corner = 50
			var tile = cornerTile.instantiate()
			parent.add_child.call_deferred(tile)
			if lastCornerRight:
				tile.get_child(0).scale.y *= -1
				tile.get_child(0).get_child(0).rotation = PI
				tile.get_child(0).position.x = -24
				
			tile.global_position = newestBranch.global_position
			tile.rotation = newestBranch.global_rotation
			newestBranch = tile.get_child(0).get_child(0)
			lastCornerRight = not lastCornerRight
		else:
			corner -= 1
			var tile = straightTile.instantiate()
			parent.add_child.call_deferred(tile)
			tile.global_position = newestBranch.global_position
			tile.rotation = newestBranch.global_rotation
			newestBranch = tile.get_child(0).get_child(0)

func genBatch(length):
	print("chur")
	var parent = Node2D.new()
	get_tree().root.add_child.call_deferred(parent)
	parentList.push_front(parent)
	for i in range(length): newTile(parent)
