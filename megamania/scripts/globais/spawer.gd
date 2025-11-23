extends Node

func hamburguer():
	var cols = 9
	var rows = 3
	var spacing = Vector2(140, 50)
	var offset = 70
	
	var total = cols * rows
	
	if Levels.enemies_left == 0:
		Levels.enemies_left = total

	# 1) Lista todas as posições possíveis
	var posicoes: Array[Vector2] = []

	for col in range(cols):
		var pos = Vector2(
			-(col * spacing.x),
			offset
		)
		posicoes.append(pos)
	
	for col in range(cols):
		var pos = Vector2(
			-(offset + col * spacing.x),
			offset + spacing.y
		)
		posicoes.append(pos)
	
	for col in range(cols):
		var pos = Vector2(
			-(col * spacing.x),
			offset + 2 * spacing.y
		)
		posicoes.append(pos)
			
	return posicoes

func cookie():
	var cols = 3
	var rows = 6
	var spacing = Vector2(200, -100)
	var offset = 100
	
	var total = cols * rows
	
	if Levels.enemies_left == 0:
		Levels.enemies_left = total

	# 1) Lista todas as posições possíveis
	var posicoes: Array[Vector2] = []
	var deslocamento = 1
	for row in range(rows):
		deslocamento *= -1
		for col in range(cols):
			var pos = Vector2(
					deslocamento * (offset + col * spacing.x),
					offset + row * spacing.y
				)
			posicoes.append(pos)
			
	return posicoes
