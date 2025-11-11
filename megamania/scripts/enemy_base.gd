class_name  Enemy
extends Area2D

@export var speed_y: float = 50   # velocidade de descida
@export var speed_x: float = 50   # velocidade horizontal
var screen_size: Vector2
var posicao_inicial: Vector2 = Vector2.ZERO

func _ready():
	define_timer()
	define_velocidade()
	screen_size = get_viewport_rect().size
	position = posicao_inicial

func _process(delta):
	move_pattern(delta)  # cada inimigo define sua lógica de movimento

	# Se sair da tela por baixo → reaparecer no topo
	if position.y > screen_size.y + 50:
		position.y = -50
	# Se sair da tela pelo lado → reaparecer do outro
	if position.x > screen_size.x + 50:
		position.x = -50

func define_velocidade():
	speed_y = 50
	speed_x = 50  

func move_pattern(delta):
	# função "abstrata", sobrescrita pelas subclasses
	position.y += speed_y * delta
	position.x += speed_x * delta

func shoot():
	var bullet = Levels.bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.add_to_group("bullet_enemy")
	bullet.atirar(position - Vector2(0, -50), Vector2(0, 1))

func define_timer():
	$Timer.wait_time = randf_range(5.0, 10.0) 
	$Timer.start()

func morre():
	$CollisionSound.play()
	queue_free()  # remove o inimigo

func _on_timer_timeout() -> void:
	shoot()
	$Timer.start

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet_nave"):
		morre()
		area.queue_free()
