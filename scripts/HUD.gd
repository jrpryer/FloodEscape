extends CanvasLayer


onready var player = get_tree().get_root().find_node("Player",true,false)
onready var _popGet = player.connect("popBubble", self, "popBubble")
onready var _fillGet = player.connect("fillBubble", self, "fillBubble")
#onready var i = 0
#onready var test = 0

#func _process(_delta):
#	popTest()
#	fillBubble(breath_range)

func popBubble(breath_range):
#	breath_range = float(breath_range)
#	test = breath_range
#	print("HUD Got: "+var2str(breath_range))
	if breath_range == 80:
#		print("Bubble 1 pop")
		popAnimation($AirHUD/Bubble1)
#		i -= 1
	if breath_range == 60:
#		print("Bubble 2 pop")
		popAnimation($AirHUD/Bubble2)
#		i += 1
	if breath_range == 40:
		popAnimation($AirHUD/Bubble3)
#		i += 1
	if breath_range == 20:
		popAnimation($AirHUD/Bubble4)
#		i += 1
	if breath_range == 0:
		popAnimation($AirHUD/Bubble5)
#		i += 1

#func popTest():
#	if test == 0.6:
#		print(test)


func fillBubble(breath_range):
	if breath_range > 0:
		$AirHUD/Bubble5.play("Filled")
#		i -= 1
		if breath_range >= 20:
			$AirHUD/Bubble4.play("Filled")
#			i -= 1
			if breath_range >= 40:
				$AirHUD/Bubble3.play("Filled")
#				i -= 1
				if breath_range >= 60:
					$AirHUD/Bubble2.play("Filled")
#					i -= 1
					if breath_range > 80:
						$AirHUD/Bubble1.play("Filled")
#						i -= 1


func popAnimation(node):
	node.play("Pop")
	yield( node, "animation_finished" )
	node.play("Popped")

func is_negative(number):
	if number < 0:
		return true
	else:
		return false


#signal start_game
#
#func _process(delta):
#	if Input.is_action_pressed("ui_accept"):
#		if $Button.visible:
#			_on_Start_Button_pressed()
#
#func show_message(text):
#	$MessageLabel.text = text
#	$MessageLabel.show()
#
#func show_game_over():
#	show_message("Game Over")
#	yield($MessageTimer, "timeout")
#	$MessageLabel.text = "Dodge the Creeps"
#	$MessageLabel.show()
#	yield(get_tree().create_timer(1.0), "timeout")
#	$Button.show()
#
#func _on_Start_Button_pressed():
#	$Button.hide()
#	emit_signal("start_game")
#
#func _on_MessageTimer_timeout():
#	$MessageLabel.hide()
