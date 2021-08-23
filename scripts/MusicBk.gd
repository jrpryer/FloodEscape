extends AudioStreamPlayer

func _process(_delta):
	volume_db = Floor.MusicVol
	yield( self, "finished" )
	play()
