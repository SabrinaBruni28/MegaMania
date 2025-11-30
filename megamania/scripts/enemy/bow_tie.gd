extends Bug

func move_pattern(delta):
	count += 1
	position.x += speed_x * delta
	position.y += speed_y * delta
	
	if count == 55:
		count = 0
		speed_y *= -1
		
func define_velocidade():
	posicao_inicial += Vector2(-50, 0)
	speed_x = 400
	speed_y = 200
