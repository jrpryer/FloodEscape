extends Node

signal slow
signal fast
signal normal
signal instance_node

export (PackedScene) var platform_scene
export (PackedScene) var small_platform_scene

const MIN_DIST = -520
const MAX_DIST = -30
var score = 0
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _process(delta):
	var cur_dist_top = $PlatformPath/PlatformSpawn.position.y - $Player.position.y
	var cur_dist_bottom = Floor.water_level.origin.y - $Player.position.y
	if cur_dist_top > MIN_DIST:
		print("top_moving")
#		$PlatformPath.position.y -= 100
		$PlatformPath/PlatformSpawn.position.y -= 100
	if cur_dist_bottom <= -900:
		emit_signal("slow")
	elif cur_dist_bottom > -10:
		emit_signal("fast")
	else:
		emit_signal("normal")
	
func new_game():
	$Player.reset($StartPosition.position) # Temporary
	#print(score)

func _on_Timer_timeout():
	#print($Platforms/DeathLine.position.y)
	score += 1
	var platform_spawn_location = $PlatformPath/PlatformSpawn
	
	var platform = platform_scene.instance()
	var small_platform = small_platform_scene.instance()
	
	
	if score % 2 == 0:
		$Platforms.add_child(platform)
		platform.position.x = rng.randf_range(platform_spawn_location.position.x, 576)
		platform.position.y = platform_spawn_location.position.y
	if not score % 2 == 0:
		$Platforms.add_child(small_platform)
		small_platform.position.x = rng.randf_range(platform_spawn_location.position.x, 576)
		small_platform.position.y = platform_spawn_location.position.y

#func _on_Wall_wall_death():
#	print("wall killed")
#	var wall = wall_scene.instance()
#	$Walls.add_child(wall)
#	wall.position.y = 0

func instance_node(node, location):
	print("making walls")
	var wall = node.instance()
	$Walls.add_child(wall)
	wall.global_position.y = location
