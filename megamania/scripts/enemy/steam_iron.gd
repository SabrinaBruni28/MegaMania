extends Enemy

var count = 0
var d = 30
var movimento = {
	"pause": true,
	"diagonal-dir": false,
	"diagonal-esq": false,
	"desce": false,
	"dir": false,
	"esq": false,
}
var movimento_atual = "pause"
var movimento_novo = "pause"

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
	if movimento_atual != movimento_novo:
		movimento[movimento_atual] = false
		movimento[movimento_novo] = true
		movimento_atual = movimento_novo
		
	# Reseta o ciclo
	if count == 21*d+220:
		count = 0
		movimento_novo = "pause"
	# Parado -> diagonal direita
	if count == d+20 or count == 8*d+90  or count == 19*d+200:
		movimento_novo = "diagonal-dir"
	# Diagonal direita -> parado
	if count == 2*d+30 or count == 4*d+50 or count == 10*d+110:
		movimento_novo = "pause"
	# Parado -> desce
	if count == 3*d+40 or count == 12*d+130 or count == 14*d+150:
		movimento_novo = "desce"
	# Parado -> diagonal esquerda
	if count == 5*d+60 or count == 9*d+100 or count == 20*d+210:
		movimento_novo = "diagonal-esq"
	# Diagonal esquerda -> direita
	if count == 6*d+70 or count == 11*d+120 or count == 15*d+160 or count == 17*d+180:
		movimento_novo = "dir"
	# Direita -> esquerda
	if count == 7*d+80 or count == 13*d+140 or count == 16*d+170 or count == 18*d+190:
		movimento_novo = "esq"

func define_velocidade():
	posicao_inicial += Vector2(650, -700)
	speed_x = 400
	speed_y = 100

func define_timer():
	timer.wait_time = randf_range(20.0, 50.0) 
	timer.start()
