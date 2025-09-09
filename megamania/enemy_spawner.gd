extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 0.5  # tempo entre inimigos
@export var enemies_per_wave: int = 8    # quantos inimigos por onda

var screen_size: Vector2

func _ready():
	screen_size = get_viewport_rect().size
	start_wave()

func start_wave():
	for i in range(enemies_per_wave):
		spawn_enemy(i)
		await get_tree().create_timer(spawn_interval).timeout

func spawn_enemy(index: int):
	if enemy_scene == null:
		print("⚠️ Nenhuma cena de inimigo atribuída no Inspector!")
		return
	
	var enemy = enemy_scene.instantiate()
	get_parent().add_child(enemy)

	# começa fora da tela (à direita)
	enemy.position.x = 0
	# cada inimigo nasce mais embaixo (formando a “coluna de hambúrgueres”)
	enemy.position.y = 100 + index
