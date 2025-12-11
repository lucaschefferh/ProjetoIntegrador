extends Control

#script para pegar os dados do jogador e colocar em ordem
@onready var lista_container = $CenterContainer/PanelContainer/VBoxContainer/ScrollContainer/ListaNomes

func _ready():
	atualizar_leaderboard()

func atualizar_leaderboard():
	for filho in lista_container.get_children():
		filho.queue_free()
	
	var records = GameData.historico_pontuacao
	
	records.sort_custom(func(a, b):
		if a.get("erros", 0) != b.get("erros", 0):
			return a.get("erros", 0) < b.get("erros", 0)
		return a.get("tempo", 0) < b.get("tempo", 0)
	)
	
	if records.is_empty():
		criar_linha_texto("Nenhum registro ainda...")
	else:
		criar_linha_texto("NOME | IDADE | TEMPO | ERROS", true)
		
		for jogador in records:
			var t = jogador.get("tempo", 0)
			var mins = int(t / 60)
			var segs = int(t) % 60
			var tempo_str = "%02d:%02d" % [mins, segs]
			
			var texto_final = "%s | %d anos | %s | %d Erros" % [
				jogador.get("nome", "Anônimo"),
				jogador.get("idade", 0),
				tempo_str,
				jogador.get("erros", 0)
			]
			
			criar_linha_texto(texto_final)

func criar_linha_texto(texto: String, destaque: bool = false):
	var label = Label.new()
	label.text = texto
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	if destaque:
		label.modulate = Color.YELLOW 
	else:
		label.modulate = Color.WHITE
	
	lista_container.add_child(label)
	
	var separador = HSeparator.new()
	lista_container.add_child(separador)

func _on_button_pressed():
	# Voltar ao menu
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
