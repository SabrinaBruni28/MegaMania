extends Enemy

var count = 0
var movimento = {
	"pause": true,
	"diagonal-dir": false,
	"diagonal-esq": false,
	"desce": false,
	"dir": false,
	"esq": false,
}

func _process(delta):
	count += 1
	# Se sair da tela por baixo → reaparecer no topo
	if position.y > screen_size.y:
		position.y = -50

	move_pattern(delta)  # cada inimigo define sua lógica de movimento
	troca_movimento()

func move_pattern(delta):
	if movimento["pause"]: return
	if movimento["esq"]:
		position.x -= speed_x * delta
	if movimento["dir"]:
		position.x += speed_x * delta
	if movimento["desce"]:
		position.y += speed_y * delta
	if movimento["diagonal-dir"]:
		position.y += speed_y * delta
		position.x += speed_x * delta
	if movimento["diagonal-esq"]:
		position.y += speed_y * delta
		position.x -= speed_x * delta

func troca_movimento():
	# Reseta o ciclo
	if count == 220:
		count = 0
		movimento["diagonal-esq"] = false
		movimento["pause"] = true
	# Parado -> diagonal direita
	if count == 20:
		movimento["pause"] = false
		movimento["diagonal-dir"] = true
	# Diagonal direita -> parado
	if count == 30:
		movimento["pause"] = true
		movimento["diagonal-dir"] = false
	# Parado -> desce
	if count == 40:
		movimento["pause"] = false
		movimento["desce"] = true
	# Desce -> parado
	if count == 50:
		movimento["pause"] = true
		movimento["desce"] = false
	# Parado -> diagonal esquerda
	if count == 60:
		movimento["pause"] = false
		movimento["diagonal-esq"] = true
	# Diagonal esquerda -> direita
	if count == 70:
		movimento["diagonal-esq"] = false
		movimento["dir"] = true
	# Direita -> esquerda
	if count == 80 or count == 190:
		movimento["dir"] = false
		movimento["esq"] = true
	# Esquerda -> Diagonal direita
	if count == 90 or count == 200:
		movimento["esq"] = false
		movimento["diagonal-dir"] = true
	# Diagonal direita -> Diagonal esquerda
	if count == 100 or count == 210:
		movimento["diagonal-dir"] = false
		movimento["diagonal-esq"] = true
	# Diagonal esquerda -> parado
	if count == 110:
		movimento["diagonal-esq"] = false
		movimento["pause"] = true
	# Parado -> direita
	if count == 120:
		movimento["pause"] = false
		movimento["dir"] = true
	# Direita -> desce
	if count == 130:
		movimento["dir"] = false
		movimento["desce"] = true
	# Desce -> esquerda
	if count == 140 or count == 170:
		movimento["desce"] = false
		movimento["esq"] = true
	# Esquerda -> desce
	if count == 150:
		movimento["desce"] = true
		movimento["esq"] = false
	# Desce -> direita
	if count == 160:
		movimento["desce"] = false
		movimento["dir"] = true
	# Esquerda -> direita
	if count == 180:
		movimento["esq"] = false
		movimento["dir"] = true

func define_velocidade():
	posicao_inicial += Vector2(500, -500)
	speed_x = 400  
	speed_y = 300
