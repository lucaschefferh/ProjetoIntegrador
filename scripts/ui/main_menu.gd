extends Control

func _ready():
	var jogar = $VBoxContainer/Button_Jogar
	var creditos = $VBoxContainer/Button_Creditos
	var sair = $VBoxContainer/Button_Sair
	
	# Conexões manuais dos botões de navegação
	jogar.pressed.connect(_on_jogar_pressed)
	creditos.pressed.connect(_on_creditos_pressed)
	sair.pressed.connect(_on_sair_pressed)
	
	# Configuração Inicial do Botão de Música
	if has_node("/root/BackgroundMusic"):
		var musica = get_node("/root/BackgroundMusic")
		# Sincroniza o visual do botão com o estado real da música
		# Se a música NÃO está pausada (!paused), o botão fica pressionado (ON)
		$VBoxContainer/Button_Musica.button_pressed = !musica.stream_paused

func _on_jogar_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu/profile_menu.tscn")

# Se você tiver um botão de ranking na cena, lembre de conectar o sinal dele também!
func _on_button_ranking_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/ranking.tscn") # Confira se o nome do arquivo é ranking ou score_screen

func _on_creditos_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu/creditos.tscn")

func _on_sair_pressed():
	get_tree().quit()

# --- A CORREÇÃO ESTÁ AQUI ---
func _on_button_musica_toggled(toggled_on: bool) -> void:
	if has_node("/root/BackgroundMusic"):
		var musica = get_node("/root/BackgroundMusic")
		
		# A lógica:
		# toggled_on = true (Ligado) -> stream_paused = false (Toca)
		# toggled_on = false (Desligado) -> stream_paused = true (Mudo)
		musica.stream_paused = not toggled_on
