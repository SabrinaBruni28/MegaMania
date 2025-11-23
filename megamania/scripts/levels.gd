extends Node

# Levels
var levels = ["hamburguer", "cookie"]
var level: int = 1
# Atributos do player
var vidas: int = 3
var pontuacao: int = 0
var posicao: Vector2 = Vector2.ZERO
# Atributos do jogo
var enemies_left := 0
var velocidade: int = 1
# Sinal
signal vida
# Bullet
var bullet_scene = preload("res://scenes/bullet.tscn")

func reset_jogo():
	level = 1
	vidas = 3
	velocidade = 1
	pontuacao = 0
	posicao = Vector2.ZERO
	enemies_left = 0

func next_level():
	level += 1
	if level > levels.size():
		level = 1
		velocidade += 1
	reinicia_jogo()

func prepare_level():
	var enemy = load("res://scenes/enemies/" + levels[level -1] + ".tscn")

	# 1) Lista todas as posições possíveis
	var posicoes = Spawer.call(levels[level - 1])
	var count := enemies_left

	# 2) Embaralha
	posicoes.shuffle()

	# 3) Pega apenas as primeiras `count`
	for i in range(min(count, posicoes.size())):
		var e = enemy.instantiate()
		e.posicao_inicial = posicoes[i]
		get_tree().current_scene.add_child(e)
		# acelera
		e.acelerar_enemy(velocidade)

func remove_vida():
	if vidas == 0:
		termina_jogo()
		return
	vidas -= 1
	reinicia_jogo()

func remove_enemy():
	enemies_left -= 1

func soma_pontuacao(pontos:int = 100):
	pontuacao += pontos
	if pontuacao % 10000 == 0:
		emit_signal("vida")

func reinicia_jogo():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/jogo.tscn")

func termina_jogo():
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://scenes/get_nome.tscn")
	
