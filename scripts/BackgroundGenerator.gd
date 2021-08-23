extends Position2D

export(PackedScene) var Background
export(int) var grid_size

var speed
var world
var camera
var yPosition

signal instance_node_bk(node, loction)

func _ready():
	world = get_tree().get_root().find_node("World",false,false)
	camera = get_tree().get_root().find_node("Camera2D",true,false)
	yPosition = camera.get_camera_screen_center()
	var _conInstance = connect("instance_node_bk", world, "instance_node_bk")
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
	if position.y >= -7168:
		makeBackground()
	#elif (global_position.y - yPosition.y ) <= -512:
	#	makeWalls()
	#	makeWalls()
	#	makeWalls()
	#	makeWalls()
	#   makeWalls()
	else:
		position.y += speed
		
func makeBackground():
	position.y -= grid_size - speed
	emit_signal("instance_node_bk", Background, position.y)
