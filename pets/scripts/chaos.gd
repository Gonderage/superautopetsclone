extends "res://Pet.gd"

var disp = 0

func _process(delta):
	position.x += sin(disp*4)
	disp += delta*3
