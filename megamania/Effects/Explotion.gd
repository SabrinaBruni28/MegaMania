extends CPUParticles2D

func _ready():
	emitting = true  # começa a explosão
	await get_tree().create_timer(lifetime).timeout
	queue_free()  # destrói depois do efeito
