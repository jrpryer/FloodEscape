extends Node

signal slow
signal fast
signal normal
signal instance_node
signal instance_node_bk

export (PackedScene) var platformR_scene
export (PackedScene) var platformL_scene
export (PackedScene) var small_platformR_scene
export (PackedScene) var small_platformL_scene

const MIN_DIST = -520
const MAX_DIST = -30
const STARTSPEED = 1
var global_speed = STARTSPEED
var score = 0
var rng = RandomNumberGenerator.new()
var rando
var cur_dist_top
var cur_dist_bottom

var platform_spawn_location
var platform_spawn

func _ready():
	global_speed = 0
	yield(get_tree().create_timer(2), "timeout")
	$NewGameScreen/NewGame.visible = false
	global_speed = STARTSPEED
	$Platforms/Timer.start()


func _process(_delta):
	cur_dist_top = $PlatformPath.position.y - $Player.position.y
	cur_dist_bottom = Floor.water_level.origin.y - $Player.position.y
	platform_spawn = $PlatformPath/PlatformSpawn
	if not global_speed == 0: 
		set_global_speed(max(1, score/20))
		move_PlatformSpawn()

func set_global_speed(increment):
	if cur_dist_bottom <= -900:
		#"slow"
		global_speed = .7*(STARTSPEED*(increment*1.5))
	elif cur_dist_bottom > -10:
		#"fast"
		global_speed = 3*(STARTSPEED*(increment/2.5))
	else:
		#"normal"
		global_speed = 2*(STARTSPEED*increment)
	
func move_PlatformSpawn():
	$PlatformPath.global_position.y -= max(global_speed*2, 5)
	$PlatformPath/PlatformSpawn.global_position.y -= max(global_speed*2, 5)
	if cur_dist_top > MIN_DIST:
		#print("top_moving")
		$PlatformPath.global_position.y -= 75
		$PlatformPath/PlatformSpawn.global_position.y -= 75
		
		
func instance_node(node, location):
	var wall = node.instance()
	$Walls.add_child(wall)
	wall.global_position.y = location

func instance_node_bk(node, location):
	var bkgrnd = node.instance()
	$Backgrounds.add_child(bkgrnd)
	bkgrnd.position.y = location

func new_game():
	$Player.reset($StartPosition.position) # Temporary
	$Player.breath = 1 # Temporary	
	
	
func _on_Timer_timeout():
	score += 1
	makePlatform()
	yield(get_tree().create_timer(0.25), "timeout")
	makePlatform()

func makePlatform():
	platform_spawn.unit_offset = randi()
#	platform_spawn_location = $PlatformPath.position.y
	platform_spawn_location = round(platform_spawn.global_position.y)
	
	var plaformInstancePos = round(platform_spawn.position.x)
	
	var platformR = platformR_scene.instance()
	var platformL = platformL_scene.instance()
	var small_platformR = small_platformR_scene.instance()
	var small_platformL = small_platformL_scene.instance()
	
	
	if plaformInstancePos in range(288):
		if plaformInstancePos >= 0 and not plaformInstancePos > 144:
			$Platforms.add_child(platformL)
			platformL.position = Vector2(plaformInstancePos, platform_spawn_location)
		elif plaformInstancePos >= 144 and not plaformInstancePos > 288:
			$Platforms.add_child(small_platformL)
			small_platformR.position = Vector2(plaformInstancePos, platform_spawn_location)
	elif plaformInstancePos in range(288, 577):
		if plaformInstancePos >= 288 and not plaformInstancePos > 432:
			$Platforms.add_child(platformR)
			platformR.position = Vector2(plaformInstancePos, platform_spawn_location)
		elif plaformInstancePos >= 432 and not plaformInstancePos > 576:
			$Platforms.add_child(small_platformR)
			small_platformR.position = Vector2(plaformInstancePos, platform_spawn_location)
	
	
	

#	if rando >= 1 and not rando > 25:
#		$Platforms.add_child(platformR)
#		platformR.position = platform_spawn_location.position
#		#platformR.position.x = rng.randf_range(platform_spawn_location.x+288, 576)
#		#platformR.position.y = platform_spawn_location.y
#
#	elif rando >= 50 and not rando > 75:
#		$Platforms.add_child(platformL)
#		platformL.position = platform_spawn_location.position
#		#platformR.position.x = rng.randf_range(platform_spawn_location.x, 288)
#		#platformR.position.y = platform_spawn_location.y
#
#	elif rando >= 25 and not rando > 50:
#		$Platforms.add_child(small_platformR)
#		small_platformR.position = platform_spawn_location.position
#		#small_platformR.position.x = rng.randf_range(platform_spawn_location.x+288, 576)
#		#small_platformR.position.y = platform_spawn_location.y
#	elif rando >= 75:
#		$Platforms.add_child(small_platformL)
#		small_platformR.position = platform_spawn_location.position
#		#small_platformL.position.x = rng.randf_range(platform_spawn_location.x, 288)
#		#small_platformL.position.y = platform_spawn_location.y

func _on_BeginningScene_timeout():
	var platformR1 = platformR_scene.instance()
	var platformR2 = platformR_scene.instance()
	var platformL1 = platformL_scene.instance()
	var smallplatformR1 = small_platformR_scene.instance()
	var smallplatformL1 = small_platformL_scene.instance()
	var smallplatformL2 = small_platformL_scene.instance()
	$Platforms.add_child(platformR1)
	$Platforms.add_child(platformR2)
	$Platforms.add_child(platformL1)
	$Platforms.add_child(smallplatformR1)
	$Platforms.add_child(smallplatformL1)
	$Platforms.add_child(smallplatformL2)
	platformR1.position = Vector2(504, 64)
	platformR2.position = Vector2(464, 664)
	platformL1.position = Vector2(120, 512)
	smallplatformR1.position = Vector2(504, 216)
	smallplatformL1.position = Vector2(104, 968)
	smallplatformL2.position = Vector2(102, 280)
	smallplatformL2.position = Vector2(102, 280)
