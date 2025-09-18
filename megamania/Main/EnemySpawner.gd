extends Node2D

@export var spawn_interval: float = 1.0  # tempo entre inimigos
@export var enemies_per_wave: int = 12    # quantos inimigos por onda

signal wave_finished

var screen_size: Vector2

func _ready():
	screen_size = get_viewport_rect().size

# recebe a cena do LevelManager
func start_wave(enemy_scene: PackedScene):
	if enemy_scene == null:
		print("⚠️ Nenhuma cena de inimigo recebida!")
		return

	for i in range(enemies_per_wave):
		spawn_enemy(enemy_scene, i)
		await get_tree().create_timer(spawn_interval).timeout

	# quando terminar a onda, avisa o LevelManager
	emit_signal("wave_finished")
	print("Wave terminada!")

func spawn_enemy(enemy_scene: PackedScene, index: int):
	var enemy = enemy_scene.instantiate()
	get_tree().current_scene.add_child(enemy)
