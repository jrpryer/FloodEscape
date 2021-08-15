extends CanvasLayer

signal start_game

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		if $Button.visible:
			_on_Start_Button_pressed()

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()

func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Dodge the Creeps"
	$MessageLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$Button.show()

func _on_Start_Button_pressed():
	$Button.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$MessageLabel.hide()
