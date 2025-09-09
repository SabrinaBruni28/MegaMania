extends Area2D

@export var bullet_scene: PackedScene
@export var speed: int = 400  # velocidade da nave
@export var shoot_interval: float = 0.8  # tempo entre tiros
var screen_size: Vector2
var shoot_timer: float = 0

func _ready():
	screen_size = get_viewport_rect().size
	position.x = screen_size.x/2
	position.y = screen_size.y - 50

func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1

	position += direction * speed * delta
	position.x = clamp(position.x, 50, screen_size.x - 50)  # mantém dentro da tela

	# Controle de disparo contínuo
	shoot_timer -= delta
	if Input.is_action_pressed("ui_accept"):
		if shoot_timer <= 0:
			shoot()
			shoot_timer = shoot_interval
	
func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position.x = position.x
	get_parent().add_child(bullet)
	# toca o som
	$ShootSound.play()
