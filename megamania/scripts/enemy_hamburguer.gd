extends "res://Enemies/EnemyBase.gd"

func move_pattern(delta):
	position.x += speed_x * delta

func position_inicial():
	position.x = 0
	position.y = 50
