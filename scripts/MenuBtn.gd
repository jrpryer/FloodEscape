extends Button

export var referance_path = ""
export (bool) var start_focused = false

#onready var _getMouse = connect("mouse_entered", self, "_on_Button_mouse_entered")
#onready var _getPressed = connect("pressed", self, "_on_Button_Pressed")

func _ready():
	if (start_focused):
		grab_focus()

func _process(_delta):
	if Input.is_action_just_pressed("ui_up"):
		start_focused = true

func _on_Button_mouse_entered():
	grab_focus()

func _on_Button_mouse_exited():
	release_focus()

func _on_Button_pressed():
	$ClickAudio.play()
	yield( $ClickAudio, "finished" )
	if (referance_path != ""):
		var _changeScene = get_tree().change_scene(referance_path)
	else:
		get_tree().quit()
