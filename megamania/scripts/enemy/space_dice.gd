extends Enemy

var count = 0
var descida = 0

func _process(delta):
	move_pattern(delta)  # cada inimigo define sua lógica de movimento

	# Se sair da tela por baixo → reaparecer no topo em lugar aleatório
	if position.y > screen_size.y:
		position.y = -50
		position.x = randf_range(0, screen_size.x )

func move_pattern(delta):
	position.y += speed_y * delta

func define_velocidade():
	posicao_inicial += Vector2(500, -120)  
	speed_y = 500

func define_timer():
	pass
