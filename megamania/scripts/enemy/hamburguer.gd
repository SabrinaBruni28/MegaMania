extends Enemy

func move_pattern(delta):
	position.x += speed_x * delta

func define_velocidade():
	posicao_inicial += Vector2(-50, 0)
	speed_x = 500  
