extends Node2D

@onready var barra_progresso: Node2D = $BarraProgresso

func _ready():
	Levels.prepare_level()
	get_tree().paused = true
	barra_progresso.tw.finished.connect(_on_barra_anim_end)

func _on_barra_anim_end():
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_tree().get_nodes_in_group("enemies").size() == 0:
		get_tree().paused = true
		barra_progresso.animate_unfill()
		barra_progresso.tw.finished.connect(_on_barra_anim_end)
		barra_progresso.tw.finished.connect(Levels.next_level)
