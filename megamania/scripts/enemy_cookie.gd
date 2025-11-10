extends "res://Enemies/EnemyBase.gd"

func move_pattern(delta):
	# movimento reto para baixo
	position.y += speed_y * delta
	position.x += speed_x * delta/2
	
func position_inicial():
	position.x = 0
	position.y = -10
