extends Area2D

@export var speed: int = 100
var screen_size: Vector2

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	position.x += speed * delta * 2
	if position.x > screen_size.x:  # se sair da tela pela esquerda
		position.x = 0

func _on_area_entered(area):
	if area.is_in_group("bullets"):
		queue_free()       # remove o inimigo
		area.queue_free()  # remove a bala
		# toca o som
		get_parent().get_node("CollisionSound").play()
