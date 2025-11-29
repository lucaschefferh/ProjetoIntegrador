extends Control

@onready var label_nome = $CenterContainer/PanelContainer/VBoxContainer/LabelNome
@onready var label_tempo = $CenterContainer/PanelContainer/VBoxContainer/LabelTempo
@onready var label_tentativas = $CenterContainer/PanelContainer/VBoxContainer/LabelTentativas 

func _ready():
	# 1. Para o relógio e SALVA no arquivo (Leaderboard)
	GameData.registrar_vitoria_final()
	
	# 2. Mostra os dados na tela para o jogador ver
	label_nome.text = "Parabéns, " + GameData.nome_jogador + "!"
	
	var tempo = GameData.tempo_fase
	var mins = int(tempo / 60)
	var segs = int(tempo) % 60
	label_tempo.text = "Tempo Final: %02d:%02d" % [mins, segs]
	
	if GameData.tentativas == 0:
		label_tentativas.text = "Tentativas Erradas: Nenhuma! (Perfeito)"
		label_tentativas.modulate = Color.GREEN # Fica verde pra destacar
	else:
		label_tentativas.text = "Tentativas Erradas: " + str(GameData.tentativas)
		label_tentativas.modulate = Color.WHITE

func _on_button_pressed():
	# Volta para o menu principal
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
