extends Node2D

@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var vida: Sprite2D = $Vida
@onready var pontuacao: Label = $Pontuacao
var tw

func _ready() -> void:
	inicia_vidas()
	Levels.vida.connect(adiciona_vida)
	# Barra começa vazia
	progress_bar.value = 0
	progress_bar.max_value = timer.wait_time

	# Tween para encher
	tw = create_tween()
	tw.tween_property(progress_bar, "value", progress_bar.max_value, 1.2) # 1.2s para encher

	# Quando terminar → começa o timer
	tw.finished.connect(_start_timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_bar.max_value = timer.wait_time
	progress_bar.value = timer.time_left
	atualiza_pontuacao()

func inicia_vidas():
	for i in range(Levels.vidas):
		var a = vida.duplicate()
		a.position.x += i*50
		a.visible = true
		add_child(a)

func atualiza_pontuacao():
	pontuacao.text = str(Levels.pontuacao)

func _start_timer():
	timer.start()

func adiciona_vida():
	var a = vida.duplicate()
	a.position.x += Levels.vidas * 50
	a.visible = true
	Levels.vidas += 1
	add_child(a)

func _on_timer_timeout() -> void:
	var nodes = get_tree().get_nodes_in_group("nave")
	for n in nodes:
		n.morre()
	
func animate_fill():
	progress_bar.value = 0
	var tw = create_tween()
	tw.tween_property(progress_bar, "value", progress_bar.max_value, 1.2)
	tw.finished.connect(_start_timer)
