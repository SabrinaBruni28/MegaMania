extends Node2D

@onready var barra_progresso: Node2D = $BarraProgresso
@onready var player: Player = $Player

func _ready():
	Save.load_game()
	Levels.prepare_level()
	barra_progresso.tw.finished.connect(_on_barra_anim_end)
	player.morreu.connect(pausar)

func _on_barra_anim_end():
	get_tree().paused = false

func _process(delta: float) -> void:
	if get_tree().get_nodes_in_group("enemies").size() == 0:
		barra_progresso.animate_unfill()
		barra_progresso.tw.finished.connect(_on_barra_anim_end)
		barra_progresso.tw.finished.connect(Levels.next_level)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused
		barra_progresso.timer.paused = get_tree().paused

func pausar():
	# pausa geral
	get_tree().paused = true
	
	# pausa o timer
	barra_progresso.timer.paused = true

	# despausar somente o Player (mas sem bagunçar a árvore!)
	player.process_mode = Node.PROCESS_MODE_ALWAYS
	player.animation.process_mode = Node.PROCESS_MODE_ALWAYS
