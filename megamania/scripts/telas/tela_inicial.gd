extends Control

@onready var jogar: Button = $Jogar
@onready var records: Button = $Records
@onready var controles: Button = $Controles
@onready var click: AudioStreamPlayer2D = $Click
@onready var hover: AudioStreamPlayer2D = $Hover

func _on_jogar_pressed() -> void:
	click.play()
	jogar.disabled = true
	await click.finished
	get_tree().change_scene_to_file("res://scenes/jogo.tscn")

func _on_records_pressed() -> void:
	click.play()
	records.disabled = true
	await click.finished
	get_tree().change_scene_to_file("res://scenes/telas/tela_records.tscn")

func _on_jogar_mouse_entered() -> void:
	hover.play()

func _on_records_mouse_entered() -> void:
	hover.play()

func _on_controles_pressed() -> void:
	click.play()
	controles.disabled = true
	await click.finished
	get_tree().change_scene_to_file("res://scenes/telas/tela_controles.tscn")

func _on_controles_mouse_entered() -> void:
	hover.play()
