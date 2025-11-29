extends Control

# O lugar onde vamos adicionar os nomes
@onready var lista_container = $CenterContainer/PanelContainer/VBoxContainer/ScrollContainer/ListaNomes

func _ready():
	atualizar_leaderboard()

func atualizar_leaderboard():
	# 1. Limpa a lista atual (para não duplicar se recarregar)
	for filho in lista_container.get_children():
		filho.queue_free()
	
	# 2. Pega os dados
	var records = GameData.historico_pontuacao
	
	# 3. Ordena: Quem tem MENOS ERROS ganha. Se empatar, MENOR TEMPO ganha.
	records.sort_custom(func(a, b):
		if a.get("erros", 0) != b.get("erros", 0):
			return a.get("erros", 0) < b.get("erros", 0)
		return a.get("tempo", 0) < b.get("tempo", 0)
	)
	
	# 4. Cria as linhas visuais
	if records.is_empty():
		criar_linha_texto("Nenhum registro ainda...")
	else:
		# Cabeçalho da tabela
		criar_linha_texto("NOME | IDADE | TEMPO | ERROS", true)
		
		for jogador in records:
			# Formata o tempo
			var t = jogador.get("tempo", 0)
			var mins = int(t / 60)
			var segs = int(t) % 60
			var tempo_str = "%02d:%02d" % [mins, segs]
			
			# Monta o texto: "Lucas (10) ........ 01:30 ........ 2 Erros"
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
	
	
	# Ajuste visual simples via código
	if destaque:
		label.modulate = Color.YELLOW # Título em amarelo
	else:
		label.modulate = Color.WHITE
	
	# Adiciona na lista
	lista_container.add_child(label)
	
	# Adiciona um separador simples (opcional)
	var separador = HSeparator.new()
	lista_container.add_child(separador)

func _on_button_pressed():
	# Voltar ao menu
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
