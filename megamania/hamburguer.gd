extends Area2D

@export var speed: int = 100
var screen_size: Vector2

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	position.x += speed * delta
	if position.x > screen_size.x:  # se sair da tela pela esquerda
		position.x = 0

func _on_body_entered(body):
	if body.is_in_group("bullets"):
		queue_free()       # remove o inimigo
		body.queue_free()  # remove a bala
