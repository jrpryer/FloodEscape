extends KinematicBody2D

signal fell

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_SPEED = 400
const JUMP_HEIGHT = -650
const ACCELERATION = 50
const VELOCITy = -1000

var i
var motion = Vector2()
var PlayerID

func _ready():
	PlayerID = get_instance_id()

func _physics_process(delta):
	motion.y += GRAVITY
	# Needs a max fall speed
	var friction = false
	
	if Input.is_action_pressed("move_right"):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("move_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
		friction = true
		motion.x = lerp(motion.x, 0, .5)

		
	if is_on_floor():
		i = 0
		if Input.is_action_just_pressed("move_up"):
			motion.y = JUMP_HEIGHT
			i = 1
		if friction == true:
			motion.x = lerp(motion.x, 0, .5)
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
			motion.y = min(motion.y, 5*MAX_SPEED)
		if friction == true:
			motion.x = lerp(motion.x, 0, .05)
		if Input.is_action_just_pressed("move_up") and i > 0:
			motion.y = 0+.7*JUMP_HEIGHT
			#i -= 1
	
	motion = move_and_slide(motion, UP)
	pass

func reset(pos):
	position = pos

func _on_Floor_body_shape_entered(body_id, _body, _body_shape, _local_shape):
	if body_id == PlayerID:
		emit_signal("fell")
