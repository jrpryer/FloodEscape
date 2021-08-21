extends Button

export var referance_path = ""
export (bool) var start_focused = false
var camera

func _ready():
	if (start_focused):
		grab_focus()
	
	connect("mouse_entered", self, "_on_Button_mouse_entered")
	connect("pressed", self, "_on_Button_Pressed")

	#rect_position.x = 18
	#camera = get_tree().get_root().find_node("Camera2D",true,false)
	
func _process(delta):
	#if not camera == null:
	#	var yPosition = camera.get_camera_screen_center()
	#	rect_position.y = yPosition.y-496
	#else:
	#	pass
	if Input.is_action_pressed("ui_cancel"):
		_on_Button_pressed()

func _on_Button_mouse_entered():
	grab_focus()

func _on_Button_mouse_exited():
	release_focus()

func _on_Button_pressed():
	if (referance_path != ""):
		get_tree().change_scene(referance_path)
	else:
		get_tree().quit()


