extends Control

@onready var grid_container: GridContainer = $GridContainer

func _ready():
	Save.load_game()
	atualizar_ranking()

func atualizar_ranking():
	var ranking = Save.lista_records

	# ordena por pontos (maior primeiro)
	ranking.sort_custom(func(a, b):
		return a["pontos"] > b["pontos"]
	)
	
	if ranking.size() > 15:
		ranking = ranking.slice(0, 15)
		Save.lista_records = ranking
		Save.save_game()

	# cria novos labels no grid
	for item in ranking:
		var label = Label.new()
		var settings: LabelSettings = load("res://tres/records.tres")
		label.label_settings = settings

		label.text = "%s ------------------------------- %d" % [item["nome"], item["pontos"]]
		grid_container.add_child(label)

func reset_labels():
	# remove labels antigos
	for child in grid_container.get_children():
		child.queue_free()

func _on_sair_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/jogo.tscn")

func _on_reset_pressed() -> void:
	Save.delete_save()
	reset_labels()
	atualizar_ranking()
