extends CanvasLayer

onready var score = Floor.score
var highscore

func _ready():
	score = 0
	load_file()


func load_file():
	var file = File.new()
	if file.file_exists("user://FloodRunHighscore.dat"):
		file.open("user://FloodRunHighscore.dat", File.READ)
		highscore = file.get_var()
		file.close()
		if not highscore == null:
			displayHS()
		else:
			$Highscore.text = "Play the Game!"	
	elif not file.file_exists("user://FloodRunHighscore.dat"):
		$Highscore.text = "Play the Game!"

func displayHS():
	$Highscore.text = var2str(highscore)

#
#func load_file():
#	var file = File.new()
#	file.open("user://FloodRunHighscore.dat", File.READ)
#	var content = file.get_as_text()
#	file.close()
#	return content
