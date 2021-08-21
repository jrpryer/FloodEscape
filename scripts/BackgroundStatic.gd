extends Node2D

var speed
var deathline
var world

func _ready():
	world = get_tree().get_root().find_node("World",false,false)
	deathline = get_tree().get_root().find_node("DeathLine",true,false)
	#world.connect("slow",self,"handle_slow")
	#world.connect("normal",self,"handle_normal")
	#world.connect("fast",self,"handle_fast")

#func handle_slow():
#	#speed = .7
#	if world.score < 10:
#		speed = .7
#func handle_normal():
#	#speed = 2
#func handle_fast():
	#speed = 5

#func _physics_process(delta):
#	if position.y > Floor.world_water+1520:
#		#queue_free()
#		position.y -= 2080
#		print("moved wall")
#	else:
#		position.y += speed

func _process(_delta):
	speed = world.global_speed
	position.y += speed
	if position.y > deathline.get_global_transform().origin.y+1010:
		queue_free()
