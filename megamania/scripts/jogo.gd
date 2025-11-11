extends Node2D

func _ready() -> void:
	Levels.prepare_level()

	var cols = 12
	var rows = 2
	var spacing = Vector2(100, 50)
	var offset = 50

	for row in range(rows):
		for col in range(cols - row):
			var enemy = Levels.enemy.instantiate()
			enemy.posicao_inicial = Vector2(row*offset + col * spacing.x, offset + row * spacing.y)
			get_tree().current_scene.add_child(enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
