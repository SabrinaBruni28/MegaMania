extends Control

@onready var click: AudioStreamPlayer2D = $Click
@onready var hover: AudioStreamPlayer2D = $Hover
@onready var sair: Button = $Sair
@onready var jogar: Button = $"Jogar"

func _on_sair_pressed() -> void:
	click.play()
	sair.disabled = true
	await click.finished
	get_tree().change_scene_to_file("res://scenes/telas/tela_inicial.tscn")

func _on_jogar_pressed() -> void:
	click.play()
	jogar.disabled = true
	await click.finished
	get_tree().change_scene_to_file("res://scenes/jogo.tscn")

func _on_sair_mouse_entered() -> void:
	hover.play()

func _on_jogar_mouse_entered() -> void:
	hover.play()
