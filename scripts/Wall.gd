extends Area2D

var speed = 2

func _ready():
	add_to_group("wall")
	var world = get_tree().get_root().find_node("World",false,false)
	world.connect("slow",self,"handle_slow")
	world.connect("normal",self,"handle_normal")
	world.connect("fast",self,"handle_fast")

func handle_slow():
	speed = .7
func handle_normal():
	speed = 2
func handle_fast():
	speed = 5

#func _physics_process(delta):
#	if position.y > Floor.world_water+1520:
#		#queue_free()
#		position.y -= 2080
#		print("moved wall")
#	else:
#		position.y += speed

func _physics_process(delta):
	position.y += speed
	if position.y > Floor.world_water+1520:
		queue_free()
