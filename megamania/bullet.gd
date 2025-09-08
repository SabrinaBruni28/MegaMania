extends Area2D

@export var speed: int = 500

func _process(delta):
	position.y -= speed * delta
	if position.y < 0:
		queue_free()
