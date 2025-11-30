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
	
	if ranking.size() > 10:
		ranking = ranking.slice(0, 10)
		Save.lista_records = ranking
		Save.save_game()

	# cria novos labels no grid
	for item in ranking:
		var label = Label.new()
		var settings: LabelSettings = load("res://tres/records.tres")
		label.label_settings = settings

		var nome = _pad_right(item["nome"], 10)
		var pontos = _pad_left_zeros(item["pontos"], 10)
		label.text = "%s ------------------------------------ %s" % [nome, pontos]

		grid_container.add_child(label)

func reset_labels():
	# remove labels antigos
	for child in grid_container.get_children():
		child.queue_free()

func _on_sair_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/telas/tela_inicial.tscn")

func _on_jogar_novamente_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/jogo.tscn")

func _on_reset_pressed() -> void:
	Save.delete_save()
	reset_labels()
	atualizar_ranking()

func _pad_right(text: String, total: int) -> String:
	# retorna text cortado se maior que total, ou preenchido com espaços à direita
	if text.length() >= total:
		return text.substr(0, total)
	var res := text
	for i in range(total - text.length()):
		res += " "
	return res

func _pad_left_zeros(value: int, total: int) -> String:
	var s := str(value)
	if s.length() >= total:
		return s   # prefere manter o número completo se já for maior
	# adiciona zeros à esquerda
	while s.length() < total:
		s = "0" + s
	return s
