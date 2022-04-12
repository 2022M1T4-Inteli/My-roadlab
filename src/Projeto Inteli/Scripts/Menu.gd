# Writed by Renato Machado
extends Node2D

# Restarting game global variables
func _ready():
	Global.sprNumber = 0
	Global.satelliteTaskPoints = [0, 0]
	Global.describingTaskPoints = [0, 0]
	Global.computerTaskPoints = [0, 0]
	Global.dataTaskPoints = [0, 0]
	Global.automationTestTaskPoints = [0, 0]
	Global.points = 0
	Global.introduction = false

	Global.moneySpend = 0

	Global.totalComputer = 0

	Global.satelliteTaskComplete = false
	Global.describingTaskComplete = false
	Global.computerTaskComplete = false
	Global.dataTaskComplete = false
	Global.automationTestTaskComplete = false

	Global.objCatched = false

	Global.energy = 3

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


func _on_ButtonCredit_pressed():
	$Credit.visible = true


func _on_Button_pressed():
	$Credit.visible = false
