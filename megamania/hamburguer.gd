extends Area2D

@export var speed: int = 100

func _process(delta):
	position.y += speed * delta
	if position.y > get_viewport_rect().size.y:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("bullets"):
		queue_free()
		body.queue_free()
