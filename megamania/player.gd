extends Area2D

@export var bullet_scene: PackedScene
@export var speed: int = 300  # velocidade da nave
var screen_size: Vector2
var can_shoot: bool = true

func _ready():
	add_to_group("nave")
	screen_size = get_viewport_rect().size
	position.x = screen_size.x/2
	position.y = screen_size.y - 50

func _process(delta):
	if not can_shoot and get_tree().get_nodes_in_group("bullets").size() == 0:
		can_shoot = true

	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1

	position += direction * speed * delta
	position.x = clamp(position.x, 50, screen_size.x - 50)  # mantém dentro da tela

	if Input.is_action_pressed("ui_accept") and can_shoot:
		shoot()
	
func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position.x = position.x
	get_parent().add_child(bullet)
	# toca o som
	$ShootSound.play()
	can_shoot = false
