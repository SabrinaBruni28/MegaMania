extends Node

@export var enemy_scene: PackedScene  # Variável exportada para colocar a cena do inimigo
@export var spawn_interval: float = 1.0

var timer: float = 0.0
var screen_size: Vector2

func _ready():
	screen_size = get_viewport().get_visible_rect().size  # CORREÇÃO

func _process(delta):
	timer += delta
	if timer >= spawn_interval:
		timer = 0
		spawn_enemy()

func spawn_enemy():
	var enemy = enemy_scene.instantiate()  # cria uma instância do inimigo
	get_parent().add_child(enemy)          # adiciona dinamicamente na cena Main
	enemy.position = Vector2(randi_range(20, screen_size.x - 20), 0)
