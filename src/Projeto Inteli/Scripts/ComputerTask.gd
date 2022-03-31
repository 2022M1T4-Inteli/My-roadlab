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


func _ChanginExplanation(var frame, var title, var description):
	$Explanation/ExplanationPopup.frame = frame
	$Explanation/ExplanationPopup/TitleLabel.text = title
	$Explanation/ExplanationPopup/DescriptionLabel.text = description


# Changing sprite frame according the button clicked
func _on_ButtonProcessador_pressed():
	_StartingExplanationScreen()
	_ChanginExplanation(0, "Processador", "O processador, também conhecido como CPU é a unidade\n central de processamento de um computador, ele funciona\n como o cérebro do computador.")


func _on_ButtonPlacaDeVideo_pressed():
	_StartingExplanationScreen()
	_ChanginExplanation(2, "Placa de Video", "A placa de video tem como função básica exibir imagens\n na tela, mas também é utilizada para rodar softwares que\n demandam grande processamento visual.")


func _on_ButtonHD_pressed():
	_StartingExplanationScreen()
	_ChanginExplanation(3, "HD", "\nO HD é um dispositivo de armazenamento de dados mais\n utilizado nos computadores. Esse tipo de equipamento guarda\n desde os seus arquivos pessoais até informações utilizadas\n exclusivamente pelo sistema operacional.")


func _on_ButtomRAM_pressed():
	_StartingExplanationScreen()
	_ChanginExplanation(1, "RAM", "A memória RAM é responsável pelo armazenamento de\n informações necessárias para a execução de aplicativos\n em uso e para ofuncionamento do próprio sistema\n operacional. Essa peça, inclusive, facilita o trabalho do\n processador que pode acessar os dados essenciais mais\n rapidamente.")


func _on_ButtonFonte_pressed():
	_StartingExplanationScreen()
	_ChanginExplanation(4, "Fonte", "A fonte tem a função de fornecer energia as demais peças do\n computador, garantindo que voltagem fornecida seja uma\n suportado pelos outros componentes.")


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
