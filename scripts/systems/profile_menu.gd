extends Control

#Sript para a parte de criação de perfil
@onready var input_nome = $PanelContainer/VBoxContainer/LineEdit
@onready var input_idade = $PanelContainer/VBoxContainer/LineEdit2 

func _ready():
	input_nome.grab_focus()

func _on_button_pressed():
	var nome_digitado = input_nome.text
	var idade_digitada = int(input_idade.text)
	
	if nome_digitado == "":
		print("Por favor, digite um nome!")
		return

	GameData.nome_jogador = nome_digitado
	GameData.idade_jogador = idade_digitada

	GameData.iniciar_nova_partida()
	
	print("Perfil Criado: ", nome_digitado, " - Cronômetro Iniciado!")

	get_tree().change_scene_to_file("res://scenes/levels/tutorial.tscn")
