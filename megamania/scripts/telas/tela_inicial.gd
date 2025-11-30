extends Control

func _on_jogar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/jogo.tscn")

func _on_records_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/telas/tela_records.tscn")
