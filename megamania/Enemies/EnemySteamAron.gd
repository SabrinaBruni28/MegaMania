extends "res://Enemies/EnemyBase.gd"

func move_pattern(delta):
	# movimento reto para baixo
	position.y += speed_y * delta
	
func position_inicial():
	position.x = 100
	position.y = -10
