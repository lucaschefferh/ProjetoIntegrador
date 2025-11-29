extends Control

# Referências aos inputs
@onready var input_nome = $PanelContainer/VBoxContainer/LineEdit
@onready var input_idade = $PanelContainer/VBoxContainer/LineEdit2 # Confira se o nome do nó é esse mesmo

func _ready():
	input_nome.grab_focus()

func _on_button_pressed():
	var nome_digitado = input_nome.text
	var idade_digitada = int(input_idade.text)
	
	if nome_digitado == "":
		print("Por favor, digite um nome!")
		return

	# 1. Salva na memória TEMPORÁRIA do GameData
	GameData.nome_jogador = nome_digitado
	GameData.idade_jogador = idade_digitada
	
	# 2. --- AQUI ESTÁ A MUDANÇA ---
	# Em vez de salvar no disco agora, nós apenas INICIAMOS A SESSÃO.
	# Isso zera o tempo e as tentativas para o jogo começar limpo.
	GameData.iniciar_nova_partida()
	
	print("Perfil Criado: ", nome_digitado, " - Cronômetro Iniciado!")
	
	# 3. Vai para o Tutorial
	get_tree().change_scene_to_file("res://scenes/levels/tutorial.tscn")
