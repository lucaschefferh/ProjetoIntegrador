extends CanvasLayer

#script do menu de pause, funciona para mostrar o menu e redirecionar o player de acordo com a escolha dele
func _ready():
	visible = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if visible:
			unpause()
		else:
			pause()

func pause():
	visible = true
	get_tree().paused = true 

func unpause():
	visible = false
	get_tree().paused = false 

func _on_button_continuar_pressed():
	unpause()

func _on_button_menu_principal_pressed(): 
	unpause() 
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")

func _on_button_sair_pressed():
	get_tree().quit()


func _on_button_menu_pressed() -> void:
	pass 
