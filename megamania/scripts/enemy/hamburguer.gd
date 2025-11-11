extends Enemy

func move_pattern(delta):
	position.x += speed_x * delta

func define_velocidade():
	speed_x = 100  
