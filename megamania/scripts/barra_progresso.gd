extends Node2D

@onready var timer: Timer = $Timer
@onready var vida: Sprite2D = $Vida
@onready var pontuacao: Label = $Pontuacao
@onready var progress_bar: ProgressBar = $ProgressBar
var tw
var dando_pontos := false
var pontos_por_segundo := 10

func _ready() -> void:
	inicia_vidas()
	animate_fill()
	Levels.vida.connect(adiciona_vida)

func _process(delta: float) -> void:
	progress_bar.max_value = timer.wait_time
	progress_bar.value = timer.time_left
	atualiza_pontuacao()
	
	if dando_pontos:
		Levels.soma_pontuacao(pontos_por_segundo)

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
	Levels.remove_vida()
	
func animate_fill():
	progress_bar.value = 0
	get_tree().paused = true
	tw = create_tween()
	tw.tween_property(progress_bar, "value", progress_bar.max_value, 1.2)
	tw.finished.connect(_start_timer)

func animate_unfill():
	dando_pontos = true

	var valor_atual := progress_bar.value
	var valor_max := progress_bar.max_value

	var tempo_total := 4.5  # tempo total para esvaziar de 100% até 0%
	var duracao := tempo_total * (valor_atual / valor_max)
	get_tree().paused = true

	tw = create_tween()
	tw.tween_property(progress_bar, "value", -5, duracao)
	tw.finished.connect(_on_unfill_finished)

func _on_unfill_finished():
	dando_pontos = false
