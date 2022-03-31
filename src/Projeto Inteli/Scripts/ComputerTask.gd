# Made by Renato Machado
extends Node2D


func _process(delta):
	# Checking if the task was completed
	if Global.totalComputer >= 6:
		get_node("/root/Level 2/TasksSpawn/Computer Task/TaskFineshed").visible = true
		get_node("/root/Level 2/TasksSpawn/Computer Task/Control/Button").visible = false
		if !Global.computerTaskComplete:
			Global.pontos += 50
			Global.energy -= 1
		Global.computerTaskComplete = true
		get_node("/root/Level 2/Player").canWalk = true
		get_node("/root/Level 2/Cenário 3").taskOcorring = false


# Reseting values if the task was closed without be completed
func _on_Button_pressed():
	Global.totalComputer = 0
	get_node("/root/Level 2/Player").canWalk = true
	get_node("/root/Level 2/Cenário 3").taskOcorring = false
	queue_free()


# Closing task
func _on_TaskFineshedButton_pressed():
	Global.totalComputer = 0
	queue_free()


# Opening explanation screen
func _StartingExplanationScreen():
	$Explanation/Background.visible = false
	$Explanation/ExplanationPopup.visible = true


# Changing sprite frame according the button clicked
func _on_ButtonProcessador_pressed():
	_StartingExplanationScreen()
	$Explanation/ExplanationPopup.frame = 0


func _on_ButtonPlacaDeVideo_pressed():
	_StartingExplanationScreen()
	$Explanation/ExplanationPopup.frame = 2


func _on_ButtonHD_pressed():
	_StartingExplanationScreen()
	$Explanation/ExplanationPopup.frame = 3


func _on_ButtomRAM_pressed():
	_StartingExplanationScreen()
	$Explanation/ExplanationPopup.frame = 1


func _on_ButtonFonte_pressed():
	_StartingExplanationScreen()
	$Explanation/ExplanationPopup.frame = 4


# Function to activate and deactivate computer components script
func _ActivatinComponents(var value):
	if $Processador:
		$Processador.set_physics_process(value)
	if $"Placa de Video":
		$"Placa de Video".set_physics_process(value)
	if $HD:
		$HD.set_physics_process(value)
	if $RAM:
		$RAM.set_physics_process(value)
	if $RAM2:
		$RAM2.set_physics_process(value)
	if $Fonte:
		$Fonte.set_physics_process(value)


# Closing explanation screen and reactivating components
func _on_ButtonCloseExplanation_pressed():
	_ActivatinComponents(true)
	$Explanation.visible = false
	$Control.visible = true


# Closing components explanation popup
func _on_ButtonCloseExplanationpopup_pressed():
	$Explanation/Background.visible = true
	$Explanation/ExplanationPopup.visible = false


# Opening explanation screen
func _on_ButtonOpenExplanation_pressed():
	_ActivatinComponents(false)
	$Explanation.visible = true
	$Control.visible = false


# Closing introduction screen
func _on_ButtonCloseIntroduction_pressed():
	$IntroductionScreen.queue_free()
