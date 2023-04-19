extends "res://Pet.gd"

var disp = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = position.x + sin(disp)
	disp += delta*3
