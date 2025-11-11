extends Node

var levels = ["hamburguer"]
var level: int = 1
var vidas: int = 3
var pontuacao: int = 0
var enemies_left := 0
var velocidade: int = 1
signal vida
var bullet_scene = preload("res://scenes/bullet.tscn")

func next_level():
	level += 1
	if level > levels.size():
		level = 1
		velocidade += 1
	reinicia_jogo()

func prepare_level():
	var enemy = load("res://scenes/enemies/" + levels[level -1] + ".tscn")

	var cols = 12
	var rows = 2
	var spacing = Vector2(100, 50)
	var offset = 50

	var total = (cols + (cols-1)) # 23 por exemplo
	if enemies_left == 0:
		enemies_left = total

	var count := enemies_left

	for row in range(rows):
		for col in range(cols - row):
			if count <= 0:
				return
			var e = enemy.instantiate()
			e.posicao_inicial = Vector2(row*offset - col * spacing.x, offset + row * spacing.y)
			get_tree().current_scene.add_child(e)
			e.acelerar_enemy(velocidade)
			count -= 1

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
	get_tree().reload_current_scene()

func termina_jogo():
	get_tree().paused = true
