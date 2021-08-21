extends Label

var camera
var world
var player

func _ready():
	camera = get_tree().get_root().find_node("Camera2D",true,false)
	player = get_tree().get_root().find_node("Player",true,false)
	
func _process(_delta):
	var label = get_global_transform()
	if not camera == null:
		var yPosition = camera.get_camera_screen_center()
		label.origin.y = yPosition.y-496
	text = "Air: " + (var2str(player.breath*100))
