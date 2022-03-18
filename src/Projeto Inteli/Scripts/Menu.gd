extends Node2D

# Checando o em qual botão o mouse está em cima para atualizar as animações
func _on_ButtonPlay_mouse_entered():
	$Control/Sprite.frame = 1


func _on_ButtonPlay_mouse_exited():
	$Control/Sprite.frame = 0


func _on_ButtonCredit_mouse_entered():
	$Control/Sprite.frame = 2


func _on_ButtonCredit_mouse_exited():
	$Control/Sprite.frame = 0


func _on_ButtonQuit_mouse_entered():
	$Control/Sprite.frame = 3


func _on_ButtonQuit_mouse_exited():
	$Control/Sprite.frame = 0


# Programação dos botões, para iniciar o jogo e para fechar o jogo
func _on_ButtonPlay_pressed():
	get_tree().change_scene_to(load("res://Scenes/Level.tscn"))


func _on_ButtonQuit_pressed():
	get_tree().quit()
