extends Node

export (PackedScene) var platformR_scene
export (PackedScene) var platformL_scene
export (PackedScene) var small_platformR_scene
export (PackedScene) var small_platformL_scene
export var _referance_path = ""

const MIN_DIST = -520
const MAX_DIST = -30
const STARTSPEED = 1
var global_speed = STARTSPEED
var rng = RandomNumberGenerator.new()
var rando
var cur_dist_top
var cur_dist_bottom

var platform_spawn_location
var platform_spawn
#onready var TitleScreen = get_tree().get_root().find_node("TitleScreen",true,false)
onready var score = Floor.score

func _ready():
	rng.randomize()
	global_speed = 0
	yield(get_tree().create_timer(2), "timeout")
	$NewGameScreen/NewGameColor.visible = false
	global_speed = STARTSPEED
	$Platforms/Timer.start()
	$MusicBk.play()


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

func dead():
	$Platforms/Timer.stop()
	var highscore = score
	save(highscore)
	var _changeScene = get_tree().change_scene(_referance_path)
	
#	$Player.reset($StartPosition.position) # Temporary
#	$Player.breath = 1 # Temporary	
	
	
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


func save(scoreDat):
	var file = File.new()
	file.open("user://FloodRunHighscore.dat", File.WRITE)
	file.store_var(scoreDat, false)
	file.close()


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
