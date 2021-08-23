extends Label

onready var wasValue = $SoundSLider.value

func _on_MuteButton_pressed():
	$Muted.visible = true
	$MuteButton.toggle_mode()
	
func _on_MuteButton_toggled(button_pressed):
	$ClickMute.play()
	yield( $ClickMute, "finished" )
	if button_pressed == true:
		$SoundSLider.value = 0
		$Muted.visible = true
	elif button_pressed == false:
		$SoundSLider.value = wasValue
		$Muted.visible = false
