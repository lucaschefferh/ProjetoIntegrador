extends CanvasLayer
# ou extends Control, dependendo do seu nó raiz

func _ready():
	# Garante que o menu comece escondido quando o jogo abrir
	visible = false

func _unhandled_input(event):
	# Captura a tecla ESC (ui_cancel)
	if event.is_action_pressed("ui_cancel"):
		if visible:
			unpause()
		else:
			pause()

func pause():
	visible = true
	get_tree().paused = true # Congela o resto do jogo

func unpause():
	visible = false
	get_tree().paused = false # Descongela o jogo

# --- FUNÇÕES DOS BOTÕES ---

func _on_button_continuar_pressed():
	unpause()

func _on_button_menu_principal_pressed(): # Confira se o nome é esse mesmo
	unpause() 
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")

func _on_button_sair_pressed():
	get_tree().quit()


func _on_button_menu_pressed() -> void:
	pass # Replace with function body.
