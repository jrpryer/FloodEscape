extends Area2D

signal death_line

var world_water = position.y
var water_level = get_global_transform()

func _process(delta):
	pass
#	$FloorSprite.play("water") # Issues with this
