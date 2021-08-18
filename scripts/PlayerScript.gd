extends KinematicBody2D

signal fell
signal underwater

const UP = Vector2(0, -1)
const PULL = 22
var grav = PULL

var max_speed = 400
var jump_height = 650
var jumps_remaining
var acceleration = 50
var veloctiy = -1000
var motion = Vector2()
var friction_power = .5
var slide_speed = 200
var running

var PlayerID
var underwater
var breath

func _ready():
	PlayerID = get_instance_id()
	var world = get_tree().get_root().find_node("World",false,false)
	world.connect("slow",self,"handle_slow")
	world.connect("normal",self,"handle_normal")
	world.connect("fast",self,"handle_fast")
	underwater = false
	breath = 1
	running = false

func _physics_process(delta):
	run(delta)
	jump()
	friction()
	gravity(grav)
	breathe(delta)
	animations()
	motion = move_and_slide(motion, UP)
	
func run(delta):
	if Input.is_action_pressed("move_right"):
		running = true
		motion.x = min(motion.x+acceleration, max_speed)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("move_left"):
		running = true
		motion.x = max(motion.x-acceleration, -max_speed)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		running = false
		$Sprite.play("Idle")
		
func jump():
	if is_on_floor() or next_to_wall():
		jumps_remaining = 2 #Recharge douple jump
		
	if Input.is_action_just_pressed("jump"):
		if motion.y > 0: 
			motion.y = 0
		if jumps_remaining > 1:
			motion.y = -jump_height
			jumps_remaining -= 1
		elif jumps_remaining > 0:
			motion.y = 0+.7*(-jump_height)
			jumps_remaining -= 1
		if not is_on_floor() and next_to_left_wall():
			motion.x += jump_height
		if not is_on_floor() and next_to_right_wall():
			motion.x -= jump_height
			
	if Input.is_action_just_released("jump") and motion.y < 0:
		motion.y = max(motion.y-.4, 0)
		#motion.y = 0
		
	if Input.is_action_just_pressed("move_down"): ##DEBUG this is an attempt to debug scene movement
		gravity(100*grav)
		
func friction():
	# I don't know if I like this speed
	if not running and is_on_floor():
		motion.x = lerp(motion.x, 0, .5)
	elif not is_on_floor():
		motion.x = lerp(motion.x, 0, .04)
	else:
		motion.x = lerp(motion.x, 0, .3)
	
func gravity(gravity):
	motion.y = min(motion.y+gravity, max_speed*3) # max fall speed
	if next_to_wall() and running:
		motion.y = min(motion.y+gravity, slide_speed)

func breathe(delta):
	if underwater:
		breath = max(breath-.07*delta, 0)
		print(breath)
	if not underwater and Input.is_action_pressed("breath"):
		breath = min(breath+.1*delta, 1)
		print(breath)
	if breath <= 0:
		breath = 0
		print("DEAD")
		emit_signal("fell")

func animations():
	if not is_on_floor():
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
	if not is_on_floor() and next_to_left_wall() and running:
		$Sprite.flip_h = false
		$Sprite.play("Cling")
	if not is_on_floor() and next_to_right_wall() and running:
		$Sprite.flip_h = true
		$Sprite.play("Cling")
	
func handle_slow():
	grav = .8*PULL
func handle_normal():
	grav = PULL #since it is normally being set to the += gravity
func handle_fast():
	grav = 1.4*PULL

func next_to_wall():
	return next_to_left_wall() or next_to_right_wall()

func next_to_left_wall():
	return $LeftWallRaycast1.is_colliding() or $LeftWallRaycast2.is_colliding() 

func next_to_right_wall():
	return $RightWallRaycast1.is_colliding() or $RightWallRaycast2.is_colliding() 

func reset(pos):
	position = pos

func _on_Floor_body_shape_entered(body_id, _body, _body_shape, _local_shape):
	if body_id == PlayerID:
		print("underwater")
		underwater = true

func _on_Floor_body_shape_exited(body_id, body, body_shape, local_shape):
	if body_id == PlayerID:
		print("safe")
		underwater = false
