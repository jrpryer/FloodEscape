extends Node

onready var player = get_tree().get_root().find_node("Player",true,false)
onready var breath
#onready var _breathInstance = connect("change_air", player, "change_air")

func _process(delta):
	breath = player.breath
	
	
func change_air(was, nowis):
	var change = was - nowis
	if not is_negative(change) and nowis in range(.8, 1):
		$Bubble1.play("Filled")
	elif is_negative(change) and not nowis in range(.8, .1):
		$Bubble1.play("Pop")
		yield( $Bubble1, "finished" )
		$Bubble1.play("Popped")
	if not is_negative(change) and nowis >.6:
		$Bubble2.play("Filled")
	elif is_negative(change) and nowis in range(.2, .4):
		$Bubble1.play("Pop")
		yield( $Bubble1, "finished" )
		$Bubble1.play("Popped")
	if not is_negative(change) and nowis in range(.8, 1):
		$Bubble1.play("Filled")
	elif is_negative(change) and nowis in range(.6, .8):
		$Bubble1.play("Pop")
		yield( $Bubble1, "finished" )
		$Bubble1.play("Popped")
	if not is_negative(change) and nowis in range(.8, 1):
		$Bubble1.play("Filled")
	elif is_negative(change) and nowis in range(.6, .8):
		$Bubble1.play("Pop")
		yield( $Bubble1, "finished" )
		$Bubble1.play("Popped")
	if not is_negative(change) and nowis in range(.8, 1):
		$Bubble1.play("Filled")
	elif is_negative(change) and nowis in range(.6, .8):
		$Bubble1.play("Pop")
		yield( $Bubble1, "finished" )
		$Bubble1.play("Popped")

func is_negative(number):
	if number < 0:
		return true
	else:
		return false
