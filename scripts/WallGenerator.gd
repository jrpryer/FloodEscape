extends Position2D

export(PackedScene) var wall
export(int) var grid_size

var speed = 2

signal instance_node(node, loction)

func _ready():
	var world = get_tree().get_root().find_node("World",false,false)
	connect("instance_node", world, "instance_node")
	
	world.connect("slow",self,"handle_slow")
	world.connect("normal",self,"handle_normal")
	world.connect("fast",self,"handle_fast")

func handle_slow():
	speed = .7
func handle_normal():
	speed = 2
func handle_fast():
	speed = 5

func _process(delta):
	if global_position.y >= -4096:
		global_position.y -= grid_size
		emit_signal("instance_node", wall, global_position.y)
	else:
		global_position.y += speed
