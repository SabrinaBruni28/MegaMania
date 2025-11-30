extends Bug

func move_pattern(delta):
	count += 1
	position.x += speed_x * delta
	if count % 10 == 0:
		position.y += speed_y * delta
	if count == 8*60:
		count = 0
		speed_y *= -1

func define_velocidade():
	posicao_inicial += Vector2(-50, 0)
	speed_x = 450
	speed_y = 300
	
func define_timer():
	timer.wait_time = randf_range(2.0, 15.0) 
	timer.start()
