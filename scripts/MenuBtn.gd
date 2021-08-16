extends Button

export var referance_path = ""
export (bool) var start_focused = false

func _ready():
	if (start_focused):
		grab_focus()
	
	connect("mouse_entered", self, "_on_Button_mouse_entered")
	connect("pressed", self, "_on_Button_Pressed")

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		start_focused = true

func _on_Button_mouse_entered():
	grab_focus()

func _on_Button_mouse_exited():
	release_focus()

func _on_Button_pressed():
	if (referance_path != ""):
		get_tree().change_scene(referance_path)
	else:
		get_tree().quit()
