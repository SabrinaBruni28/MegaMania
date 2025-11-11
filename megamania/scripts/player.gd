class_name Player
extends CharacterBody2D

@export var speed: int = 300  # velocidade da nave
var screen_size: Vector2
var can_shoot: bool = true

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta):
	if not can_shoot and get_tree().get_nodes_in_group("bullet_nave").size() == 0:
		can_shoot = true

	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_left") and position.x > 50:
		direction.x -= 1
	if Input.is_action_pressed("ui_right") and position.x < (screen_size.x -50):
		direction.x += 1

	position += direction * speed * delta
	if Input.is_action_pressed("ui_accept") and can_shoot:
		shoot()
	
func shoot():
	var bullet = Levels.bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.add_to_group("bullet_nave")
	bullet.atirar(position - Vector2(0, 50), Vector2(0, -1))
	$ShootSound.play()
	can_shoot = false

func morre():
	queue_free()  # remove a nave

func _on_area_2d_area_entered(area: Area2D) -> void:
	area.queue_free()
	morre()
