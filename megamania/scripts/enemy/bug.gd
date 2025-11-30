class_name Bug
extends Enemy

var count = 0
func move_pattern(delta):
	count += 1
	position.x += speed_x * delta
	if count % 60 == 0:
		position.y += speed_y * delta
	if count == 20*60:
		count = 0
		speed_y *= -1

func define_velocidade():
	posicao_inicial += Vector2(-50, 0)
	speed_x = 500
	speed_y = 300

func define_timer():
	timer.wait_time = randf_range(5.0, 15.0)
	timer.start()
