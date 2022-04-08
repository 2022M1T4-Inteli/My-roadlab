# Writed by Renato Machado
extends Node2D


# Checking witch buttom the mouse cursor is on top
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


# Programming the menu buttons, start button and close button
func _on_ButtonPlay_pressed():
	get_tree().change_scene_to(load("res://Scenes/Level.tscn"))


func _on_ButtonQuit_pressed():
	get_tree().quit()
