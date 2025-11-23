class_name Player
extends CharacterBody2D

@export var speed: int = 300  # velocidade da nave
var screen_size: Vector2
var can_shoot: bool = true
@onready var animation: AnimationPlayer = $Animation
signal morreu

func _ready() -> void:
	animation.play("RESET")
	screen_size = get_viewport_rect().size
	if Levels.posicao != Vector2.ZERO:
		position = Levels.posicao

func _process(delta):
	if not can_shoot and get_tree().get_nodes_in_group("bullet_nave").size() == 0:
		can_shoot = true

	var direction = Vector2.ZERO
	if Input.is_action_pressed("esquerda") and position.x > 50:
		direction.x -= 1
	if Input.is_action_pressed("direita") and position.x < (screen_size.x -50):
		direction.x += 1

	position += direction * speed * delta
	Levels.posicao = position
	if Input.is_action_pressed("atirar") and can_shoot:
		shoot()
	
func shoot():
	var bullet = Levels.bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.add_to_group("bullet_nave")
	bullet.atirar(position - Vector2(0, 50), Vector2(0, -1))
	$ShootSound.play()
	can_shoot = false

func morre():
	# Para o process normal
	set_process(false)

	# Permite processar mesmo com o jogo pausado
	process_mode = Node.PROCESS_MODE_ALWAYS
	emit_signal("morreu")
	animation.play("morre")

	await animation.animation_finished
	queue_free()
	Levels.remove_vida()

func _on_area_2d_area_entered(area: Area2D) -> void:
	morre()
	area.queue_free()
