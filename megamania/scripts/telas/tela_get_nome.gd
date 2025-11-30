extends Control

var texto: String
@onready var text_edit: TextEdit = $TextEdit
@onready var click: AudioStreamPlayer2D = $Click
@onready var hover: AudioStreamPlayer2D = $Hover
@onready var button: Button = $Button

func _process(delta: float) -> void:
	texto = text_edit.text

func _on_button_pressed() -> void:
	click.play()
	button.disabled = true
	var nome_limpo := texto.strip_edges().substr(0, 10)

	var encontrado := false
	var index := -1

	# 1. Procurar índice do jogador
	for i in Save.lista_records.size():
		if Save.lista_records[i].get("nome") == nome_limpo:
			encontrado = true
			index = i
			break

	# 2. Se encontrou o jogador, verificar e atualizar pontuação
	if encontrado:
		if Save.lista_records[index].get("pontos") < Levels.pontuacao:
			Save.lista_records[index]["pontos"] = Levels.pontuacao

	# 3. Se ainda não existe esse nome, adiciona novo
	else:
		Save.lista_records.append({
			"nome": nome_limpo,
			"pontos": Levels.pontuacao
		})

	# 4. Salva e troca de cena
	Save.save_game()
	Levels.reset_jogo()
	await click.finished
	get_tree().change_scene_to_file("res://scenes/telas/tela_records.tscn")

func _on_button_mouse_entered() -> void:
	hover.play()
