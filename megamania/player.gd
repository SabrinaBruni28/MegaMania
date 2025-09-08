extends Area2D

@export var speed: int = 300  # velocidade da nave
var screen_size: Vector2

func _ready():
	screen_size = get_viewport_rect().size

@export var bullet_scene: PackedScene

func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1

	position += direction * speed * delta
	position.x = clamp(position.x, 0, screen_size.x)

	if Input.is_action_just_pressed("ui_accept"):
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.position = position - Vector2(0, 20)
