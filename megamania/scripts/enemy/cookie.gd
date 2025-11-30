class_name Cookie
extends Enemy

var count = 0
var descida = 0

func _process(delta):
	move_pattern(delta)  # cada inimigo define sua lógica de movimento

	# Se sair da tela por baixo → reaparecer no topo
	if position.y > screen_size.y:
		position.y = -50
	# Se sair da tela pelo lado → reaparecer do outro
	if position.x > screen_size.x + 55:
		position.x = -50
	# Se sair da tela pelo lado → reaparecer do outro
	if position.x < -55:
		position.x = screen_size.x + 50

func move_pattern(delta):
	position.x += speed_x * delta
	count += 1
	descida -=1
	if count == 200:
		descida = 30
		count = 0
	if 30 >= descida && descida > 20 or 10 >= descida && descida > 0:
		position.y += speed_y * delta
	if descida == 10:
		speed_x *= -1

func define_velocidade():
	posicao_inicial += Vector2(500, -112)
	speed_x = 400  
	speed_y = 300
