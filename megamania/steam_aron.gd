extends Area2D

@export var speed_x: float = 150       # velocidade horizontal
@export var speed_y: float = 20        # descida geral
@export var amplitude_y: float = 50    # altura do zig-zag
@export var frequency: float = 2       # rapidez do zig-zag

var screen_size: Vector2
var time_passed: float = 0
var initial_y: float

func _ready():
	screen_size = get_viewport_rect().size
	position.x = 0           # começa na esquerda
	position.y = 100         # altura inicial
	initial_y = 0

func _process(delta):
	time_passed += delta
	
	# movimento horizontal
	position.x += speed_x * delta * 3
	
	# movimento vertical zig-zag + descida
	position.y = initial_y + sin(time_passed * frequency) * amplitude_y + speed_y * time_passed

	# wrap horizontal
	if position.x > screen_size.x + 50:
		position.x = -50

	# wrap vertical (quando passa do chão, volta para o topo)
	if position.y > screen_size.y + 50:
		time_passed = 0
		position.y = -50
		initial_y = position.y

func _on_area_entered(area):
	if area.is_in_group("bullets"):
		queue_free()
		area.queue_free()
