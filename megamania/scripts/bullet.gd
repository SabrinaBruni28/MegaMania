class_name Bullet
extends Area2D

@export var speed: int = 500
var direcao: Vector2 = Vector2.ZERO
var screen_size: Vector2

func _ready():
	screen_size = get_viewport_rect().size
	add_to_group("bullets")

func _process(delta):
	position += direcao * speed * delta
	if position.y <= 0 or position.y >= screen_size.y:
		queue_free()

func atirar(position_init: Vector2, direcao_init: Vector2):
	position = position_init
	direcao = direcao_init
