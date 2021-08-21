extends Label

var camera
var world

func _ready():
	camera = get_tree().get_root().find_node("Camera2D",true,false)
	world = get_tree().get_root().find_node("World",false,false)
	
func _process(_delta):
	var label = get_global_transform()
	if not camera == null:
		var yPosition = camera.get_camera_screen_center()
		label.origin.y = yPosition.y-496
	text = "Score: " + (var2str(world.score))
