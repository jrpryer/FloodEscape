extends HSlider

onready var Vol
var soundVol

func _process(_delta):
	Floor.Vol = value
#	Vol = value

#func load_file():
#	var file = File.new()
#	if file.file_exists("user://FloodRunConfig.dat"):
#		file.open("user://FloodRunConfig.dat", File.READ)
#		soundVol = file.get_var()
#		file.close()
#		if not soundVol == null:
#			Vol = soundVol
#		else:
#			$Highscore.text = "Play the Game!"	
#	elif not file.file_exists("user://FloodRunConfig.dat"):
#		$Highscore.text = "Play the Game!"
#
#func _ready():
#
#	var mainstyle = StyleBoxFlat.new()
#	var grstyle = StyleBoxFlat.new()
#	add_stylebox_override("slider", mainstyle)
#	add_stylebox_override("grabber_area", grstyle)
#
#	#Set Background Color
#	mainstyle.bg_color = Color(0, 0, 0) #Black
#	#Set Grabber Area Background Color
#	grstyle.bg_color = Color(1, 1, 1) #White
#
#	#Make both areas expand from the center and fill the rect_size
#	grstyle.expand_margin_bottom = rect_size.x / 2
#	grstyle.expand_margin_top = rect_size.x / 2
#	mainstyle.expand_margin_bottom = rect_size.x / 2
#	mainstyle.expand_margin_top = rect_size.x / 2
#
#	#Fake a fancy grabber using Grabber Area's right border (optional)
#	grstyle.border_color = Color(0.5, 0, 0) #Dark Red
#	grstyle.border_width_right = 10
