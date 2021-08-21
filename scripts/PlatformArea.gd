extends KinematicBody2D

var world
var speed
var deathline

func _ready():
	world = get_tree().get_root().find_node("World",false,false)
	deathline = get_tree().get_root().find_node("DeathLine",true,false)
	#print(speed) ##DEBUG
	#world.connect("slow",self,"handle_slow")
	#world.connect("normal",self,"handle_normal")
	#world.connect("fast",self,"handle_fast")

#func handle_slow():
#	speed = .7
#func handle_normal():
#	speed = 2
#func handle_fast():
#	speed = 5

func _physics_process(delta):
	speed = world.global_speed
	position.y += speed
	if position.y > deathline.get_global_transform().origin.y:
		queue_free()
