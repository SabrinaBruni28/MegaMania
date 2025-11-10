extends Node

@export var Spawner: Node  # só 1 spawner que recebe a cena

var levels = [
	{ "enemy_scene": preload("res://Enemies/EnemyHamburguer.tscn") },
	{ "enemy_scene": preload("res://Enemies/EnemyCookie.tscn") },
	{ "enemy_scene": preload("res://Enemies/EnemySteamAron.tscn") },
]

var current_level := 0

func _ready():
	print("LevelManager ativo!")
	# conecta o sinal do Spawner → LevelManager
	Spawner.connect("wave_finished", Callable(self, "_on_wave_finished"))
	start_level(0)

func start_level(level_index: int):
	current_level = level_index
	print("Iniciando Level", current_level + 1)

	var enemy_scene = levels[level_index]["enemy_scene"]
	Spawner.start_wave(enemy_scene)

# chamado quando o Spawner terminar a onda
func _on_wave_finished():
	print("Wave finalizada! Indo para o próximo nível...")
	next_level()

func next_level():
	if current_level + 1 < levels.size():
		start_level(current_level + 1)
	else:
		current_level = 0
		start_level(current_level)
