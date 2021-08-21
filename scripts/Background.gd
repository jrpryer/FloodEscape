extends ParallaxBackground

# export var camera_velocity: Vector2 = Vector2( 0, 100 ); 
var speed = Vector2()
var scrolling
var world

func _ready():
	world = get_tree().get_root().find_node("World",false,false)
	#world.connect("slow",self,"handle_slow")
	#world.connect("normal",self,"handle_normal")
	#world.connect("fast",self,"handle_fast")

#func handle_slow():
#	speed = Vector2(0, .7)
#func handle_normal():
#	speed = Vector2(0, 2)
#func handle_fast():
#	speed = Vector2(0, 5)


func _process(_delta):
	speed = Vector2(0, world.global_speed)
	var new_offset: Vector2 = get_scroll_offset() #+ camera_velocity * delta
	new_offset += speed
	set_scroll_offset( new_offset )	

