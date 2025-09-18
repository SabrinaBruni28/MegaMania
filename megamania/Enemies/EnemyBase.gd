extends Area2D

@export var speed_y: float = 50   # velocidade de descida
@export var speed_x: float = 50   # velocidade horizontal
@export var spawn_index: int = 0   # novo: guarda a ordem do spawn
var screen_size: Vector2

func _ready():
	screen_size = get_viewport_rect().size
	add_to_group("enemies")
	position_inicial()

func position_inicial():
	# função "abstrata", sobrescrita pelas subclasses
	position.y = 0
	position.x = 0

func _process(delta):
	move_pattern(delta)  # cada inimigo define sua lógica de movimento

	# Se sair da tela por baixo → reaparecer no topo
	if position.y > screen_size.y + 50:
		position.y = -10
	# Se sair da tela pelo lado → reaparecer do outro
	if position.x > screen_size.x + 50:
		position.x = -10

func move_pattern(delta):
	# função "abstrata", sobrescrita pelas subclasses
	position.y += speed_y * delta

func _on_area_entered(area):
	if area.is_in_group("bullets"):
		queue_free()
		area.queue_free()
		get_parent().get_node("CollisionSound").play()

	elif area.is_in_group("nave"):
		explode()
		area.explode()
		get_parent().get_node("CollisionSound").play()

func explode():
	# instanciando explosão
	var explosion_scene = preload("res://Effects/Explosion.tscn")
	var explosion = explosion_scene.instantiate()
	explosion.position = position
	get_tree().current_scene.add_child(explosion)

	queue_free()  # remove o inimigo
