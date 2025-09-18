extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 1.5
var timer := 0.0
var screen_size: Vector2
var active: bool = false   # só spawna quando estiver ativo

func _ready():
	screen_size = get_viewport().get_visible_rect().size

func _process(delta):
	if not active:
		return

	timer += delta
	if timer >= spawn_interval:
		timer = 0
		spawn_enemy()

func spawn_enemy():
	if enemy_scene == null:
		return

	var enemy = enemy_scene.instantiate()
	get_parent().add_child(enemy)
	enemy.position = Vector2(randi_range(20, screen_size.x - 20), 0)
