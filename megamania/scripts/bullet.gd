extends Area2D

@export var speed: int = 500
var screen_size: Vector2

func _ready():
	add_to_group("bullets")
	screen_size = get_viewport_rect().size
	position.y = screen_size.y - 80

func _process(delta):
	position.y -= speed * delta
	if position.y <= 0:
		queue_free()
