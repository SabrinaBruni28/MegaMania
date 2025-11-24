extends Node

func hamburguer(enemy: Resource):
	var cols = 9
	var rows = 3
	var spacing = Vector2(140, 50)
	var offset = 70
	
	var total = cols * rows
	
	if Levels.enemies_left == 0:
		Levels.enemies_left = total

	# 1) Lista todas as posições possíveis
	var inimigos: Array = []

	for col in range(cols):
		var pos = Vector2(
			-(col * spacing.x),
			offset
		)
		var e = enemy.instantiate()
		e.posicao_inicial = pos
		inimigos.append(e)
	
	for col in range(cols):
		var pos = Vector2(
			-(offset + col * spacing.x),
			offset + spacing.y
		)
		var e = enemy.instantiate()
		e.posicao_inicial = pos
		inimigos.append(e)
	
	for col in range(cols):
		var pos = Vector2(
			-(col * spacing.x),
			offset + 2 * spacing.y
		)
		var e = enemy.instantiate()
		e.posicao_inicial = pos
		inimigos.append(e)
			
	return inimigos

func cookie(enemy: Resource):
	var cols = 3
	var rows = 6
	var spacing = Vector2(200, -100)
	var offset = 100
	
	var total = cols * rows
	
	if Levels.enemies_left == 0:
		Levels.enemies_left = total

	# 1) Lista todas as posições possíveis
	var inimigos: Array = []
	var deslocamento = 1
	for row in range(rows):
		deslocamento *= -1
		for col in range(cols):
			var pos = Vector2(
					deslocamento * (offset + col * spacing.x),
					offset + row * spacing.y
				)
			var e = enemy.instantiate()
			e.posicao_inicial = pos
			inimigos.append(e)
			
	return inimigos

func bug(enemy: Resource):
	return hamburguer(enemy)

func radial_tire(enemy: Resource):
	var cols = 3
	var rows = 6
	var spacing = Vector2(200, -100)
	var offset = 100
	
	var total = cols * rows
	
	if Levels.enemies_left == 0:
		Levels.enemies_left = total

	# 1) Lista todas as posições possíveis
	var inimigos: Array = []
	var deslocamento = 1
	for row in range(rows):
		deslocamento *= -1
		for col in range(cols):
			var pos = Vector2(
					deslocamento * (offset + col * spacing.x),
					offset + row * spacing.y
				)
			var e = enemy.instantiate()
			e.posicao_inicial = pos
			e.speed_x = deslocamento # Cada linha vai num sentido diferente
			inimigos.append(e)
			
	return inimigos
 
