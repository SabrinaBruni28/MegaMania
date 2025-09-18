extends Node

@export var SpawnerA: Node
@export var SpawnerB: Node

var current_level := 0
var awaiting_next_level := false

var levels = [
	{ "spawners": [SpawnerA] },
	{ "spawners": [SpawnerB] }
]

func _ready():
	print("LevelManager ativo!")
	SpawnerA.connect("wave_finished", Callable(self, "_on_wave_finished"))
	SpawnerB.connect("wave_finished", Callable(self, "_on_wave_finished"))
	start_level(0)

func start_level(level_index: int):
	current_level = level_index
	print("Start Level", current_level + 1)

	for spawner in levels[level_index]["spawners"]:
		if spawner and spawner.has_method("start_wave"):
			spawner.start_wave()

func _on_wave_finished():
	if not awaiting_next_level:
		awaiting_next_level = true
		await get_tree().create_timer(1.0).timeout
		next_level()
		awaiting_next_level = false

func next_level():
	if current_level + 1 < levels.size():
		start_level(current_level + 1)
	else:
		print("🎉 Você zerou o jogo!")
