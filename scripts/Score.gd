extends Label

var world

func _ready():
	world = get_tree().get_root().find_node("World",false,false)
	
func _process(_delta):
	text = "Score: " + (var2str(world.score))
