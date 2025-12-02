extends Node2D

@onready var timer: Timer = $Timer
@onready var vida: Sprite2D = $Vida
@onready var pontuacao: Label = $Pontuacao
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var audio_fill: AudioStreamPlayer2D = $Fill
@onready var audio_unfill: AudioStreamPlayer2D = $Unfill

var tw
var dando_pontos := false
var pontos_por_segundo := 10

func _ready() -> void:
	inicia_vidas()
	animate_fill()
	Levels.vida.connect(adiciona_vida)
	pontos_por_segundo = (10 + Levels.level * 10 + (Levels.velocidade - 1) * 80)/2

func _process(delta: float) -> void:
	progress_bar.max_value = timer.wait_time
	progress_bar.value = timer.time_left
	atualiza_pontuacao()
	
	if dando_pontos:
		if not audio_unfill.playing: audio_unfill.play()
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
	audio_fill.stop()
	timer.start()

func adiciona_vida():
	var a = vida.duplicate()
	a.position.x += Levels.vidas * 50
	a.visible = true
	Levels.vidas += 1
	add_child(a)

func _on_timer_timeout() -> void:
	set_process(false)
	var nodes = get_tree().get_nodes_in_group("nave")
	for n in nodes:
		n.morre()
	
func animate_fill():
	progress_bar.value = 0
	get_tree().paused = true
	tw = create_tween()
	audio_fill.play()
	tw.tween_property(progress_bar, "value", progress_bar.max_value, 2.0)
	tw.finished.connect(_start_timer)

func animate_unfill():
	dando_pontos = true

	var valor_atual := progress_bar.value
	var valor_max := progress_bar.max_value

	var tempo_total := 8.0  # tempo total para esvaziar de 100% até 0%
	var duracao := tempo_total * (valor_atual / valor_max)
	get_tree().paused = true

	tw = create_tween()
	tw.tween_property(progress_bar, "value", 0, duracao)
	tw.finished.connect(_on_unfill_finished)

func _on_unfill_finished():
	await audio_unfill.finished
	dando_pontos = false
