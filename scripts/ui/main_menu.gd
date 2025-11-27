extends Control

func _ready():
	var jogar = $VBoxContainer/Button_Jogar
	var creditos = $VBoxContainer/Button_Creditos
	var sair = $VBoxContainer/Button_Sair

	jogar.pressed.connect(_on_jogar_pressed)
	creditos.pressed.connect(_on_creditos_pressed)
	sair.pressed.connect(_on_sair_pressed)

func _on_jogar_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/fase1.tscn")

func _on_creditos_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu/creditos.tscn")

func _on_sair_pressed():
	get_tree().quit()
