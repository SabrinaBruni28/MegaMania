extends Node
# Caminho do arquivo de save
const SAVE_PATH := "user://records.save"
var lista_records: Array

func save_game() -> void:
	var data := {
		"lista_records": lista_records,
	}

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data, "\t"))  # salva com indentação
		file.close()
		print("💾 Records salvo")
	else:
		push_error("❌ Erro ao salvar o records! Não foi possível abrir o arquivo.")

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("⚠️ Nenhum save encontrado.")
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		push_error("❌ Erro ao abrir o arquivo de save!")
		return

	var text = file.get_as_text()
	file.close()

	var json = JSON.parse_string(text)
	if typeof(json) != TYPE_DICTIONARY:
		push_error("❌ Erro ao carregar save: arquivo corrompido ou formato inválido.")
		return

	var data: Dictionary = json

	# Restaura os dados
	lista_records = data.get("lista_records", [])

	print("✅ Records carregado com sucesso!")

func delete_save() -> void:
	reset_progresso()
	if not FileAccess.file_exists(SAVE_PATH):
		print("⚠️ Nenhum arquivo de save encontrado para deletar.")
		return

	DirAccess.remove_absolute(SAVE_PATH)
	print("🗑️ Arquivo de save deletado com sucesso!")

# 🔁 Reseta o progresso na memória (não apaga o arquivo)
func reset_progresso() -> void:
	lista_records.clear()
	print("🔄 Records reiniciado (memória limpa, mas arquivo mantido).")
