extends Position2D

export(PackedScene) var wall

export(int) var grid_size

signal instance_node(node, loction)

func _ready():
	var world = get_tree().get_root().find_node("World",false,false)
	connect("instance_node", world, "instance_node")
	print(global_position.y)

func _process(delta):
	if global_position.y > -4096:
		emit_signal("instance_node", wall, global_position.y)
		global_position.y -= grid_size
