extends Control

#script do main menu para redirecionar os jogadores aos lugares corretamente

func _ready():
	var jogar = $VBoxContainer/Button_Jogar
	var creditos = $VBoxContainer/Button_Creditos
	var sair = $VBoxContainer/Button_Sair
	
	jogar.pressed.connect(_on_jogar_pressed)
	creditos.pressed.connect(_on_creditos_pressed)
	sair.pressed.connect(_on_sair_pressed)
	

	if has_node("/root/BackgroundMusic"):
		var musica = get_node("/root/BackgroundMusic")
		$VBoxContainer/Button_Musica.button_pressed = !musica.stream_paused

func _on_jogar_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu/profile_menu.tscn")

func _on_button_ranking_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/ranking.tscn") 
	
func _on_creditos_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu/creditos.tscn")

func _on_sair_pressed():
	get_tree().quit()


func _on_button_musica_toggled(toggled_on: bool) -> void:
	if has_node("/root/BackgroundMusic"):
		var musica = get_node("/root/BackgroundMusic")
		musica.stream_paused = not toggled_on
