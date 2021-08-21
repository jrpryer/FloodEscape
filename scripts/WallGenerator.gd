extends Position2D

export(PackedScene) var wall
export(int) var grid_size

var speed
var world
var camera
var yPosition

signal instance_node(node, loction)

func _ready():
	world = get_tree().get_root().find_node("World",false,false)
	camera = get_tree().get_root().find_node("Camera2D",true,false)
	yPosition = camera.get_camera_screen_center()
	var _conInstance = connect("instance_node", world, "instance_node")
	speed = world.global_speed
	#world.connect("slow",self,"handle_slow")
	#world.connect("normal",self,"handle_normal")
	#world.connect("fast",self,"handle_fast")

#func handle_slow():
#	speed = .7
#func handle_normal():
#	speed = 2
#func handle_fast():
#	speed = 5

func _process(_delta):
	speed = world.global_speed
	global_position.y += speed
	if global_position.y >= -6144:
		makeWalls()
	#elif (global_position.y - yPosition.y ) <= -512:
	#	makeWalls()
	#	makeWalls()
	#	makeWalls()
	#	makeWalls()
	#   makeWalls()
	else:
		global_position.y += speed
		
func makeWalls():
	global_position.y -= grid_size - speed
	emit_signal("instance_node", wall, global_position.y)
