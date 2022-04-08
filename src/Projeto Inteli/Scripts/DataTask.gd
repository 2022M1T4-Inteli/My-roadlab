# Writed by Renato Machado
extends Node2D

# Declaring Variables
var buttonSelecteds = [0, 0, 0]
var correctAnswers = 0
var textTitleIndex = ["Dentre as placas abaixo, selecione aquelas onde a soma de seus números é igual a 12.", 
				"Dentre as pessoas abaixo, selecione aquelas que possuem idade maior que 19 e menor que 37.", 
				"Dentre os produtos abaixo, selecione aqueles com desconto maior que 30%.", 
				"Dentre os produtos abaixo, selecione aqueles com mais de 1000 unidades vendidas ou com menos de 10 unidades vendidas.", 
				"Dentre os animais abaixo, selecione aqueles que são quadrúpedes.", 
				"Dentre as peças de computador abaixo, selecione aquelas cujo preço é maior ou igual a R$350 e menor ou igual a R$700."]
var textOptionIndex = [{
	"select1": "BRA2E19",
	"select2": "ARG5B25",
	"select3": "INT3L18"},
	{
	"select1": "João Carvalho Araujo, 19 anos",
	"select2": "Mariana de Souza Filho, 37 anos",
	"select3": "Filipe Montenegro Ferreira, 27 anos"
	},
	{
	"select1": "Camiseta, preço sem desconto R$100, preço com desconto R$70.",
	"select2": "Calça jeans, preço sem desconto R$200, preço com desconto R$140.",
	"select3": "Tênis, preço sem desconto R$1000, preço com desconto R$500."
	},
	{
	"select1": "Laptop, 1000 unidades vendidas.",
	"select2": "Smartphone, 5020 unidades vendidas.",
	"select3": "Televisão, 10 unidades vendidas."
	},
	{
	"select1": "Penguins",
	"select2": "Gatos",
	"select3": "Cães"
	},
	{
	"select1": "Processador - R$700,00",
	"select2": "Memória - R$350,00",
	"select3": "Placa gráfica - R$349,99"
	}]
var taskChallenge = 0
var transfering = false


func _ready():
	# Setting first parameters
	$Control/ChallengeTitle.text = textTitleIndex[0]
	$Control/SelectButton1/SelectButton1Text.text = textOptionIndex[0].select1
	$Control/SelectButton2/SelectButton2Text.text = textOptionIndex[0].select2
	$Control/SelectButton3/SelectButton3Text.text = textOptionIndex[0].select3
	$Control/SelectButton1.disabled = true
	$Control/SelectButton2.disabled = true
	$Control/SelectButton3.disabled = true


# Openning tasks congrats screen
func _FineshedAllSteps():
	if correctAnswers >= 5:
		$TaskFineshed.visible = true
		$Control/TaskButtonClose.visible = false
	else:
		$TaskRetry.visible = true
	pass


# Changing sprite color according the answer
func _CheckingAnswers(var index, var answer):
	var path =  get_node("/root/Level 3/TasksSpawn/DataTask/Control/Correct-Wrong/CorrectWrongSprite" + index) 
	path.visible = true
	if answer == 1:
		path.frame = 1
	else:
		path.frame = 0


# Checking if the challenge answer
func _NextChallenge():
	match taskChallenge:
		0:
			if buttonSelecteds[0] == 1 && buttonSelecteds[1] == 1 && buttonSelecteds[2] == 1:
				correctAnswers += 1
				_CheckingAnswers("1", 1)
			else:
				_CheckingAnswers("1", 0)
			_ResetingValues(1)
		1:
			if buttonSelecteds[0] == 0 && buttonSelecteds[1] == 0 && buttonSelecteds[2] == 1:
				correctAnswers += 1
				_CheckingAnswers("2", 1)
			else:
				_CheckingAnswers("2", 0)
			_ResetingValues(2)
		2:
			if buttonSelecteds[0] == 0 && buttonSelecteds[1] == 0 && buttonSelecteds[2] == 1:
				correctAnswers += 1
				_CheckingAnswers("3", 1)
			else:
				_CheckingAnswers("3", 0)
			_ResetingValues(3)
		3:
			if buttonSelecteds[0] == 0 && buttonSelecteds[1] == 1 && buttonSelecteds[2] == 0:
				correctAnswers += 1
				_CheckingAnswers("4", 1)
			else:
				_CheckingAnswers("4", 0)
			_ResetingValues(4)
		4:
			if buttonSelecteds[0] == 0 && buttonSelecteds[1] == 1 && buttonSelecteds[2] == 1:
				correctAnswers += 1
				_CheckingAnswers("5", 1)
			else:
				_CheckingAnswers("5", 0)
			_ResetingValues(5)
		5:
			if buttonSelecteds[0] == 1 && buttonSelecteds[1] == 1 && buttonSelecteds[2] == 0:
				correctAnswers += 1
				_CheckingAnswers("6", 1)
			else:
				_CheckingAnswers("6", 0)
			
			_FineshedAllSteps()
			pass


# Reseting all task components parameters
func _ResetingValues(var index):
	buttonSelecteds[0] = 0
	buttonSelecteds[1] = 0
	buttonSelecteds[2] = 0
	taskChallenge += 1
	$Control/ChallengeTitle.text = textTitleIndex[index]
	$Control/SelectButton1/SelectButton1Text.text = textOptionIndex[index].select1
	$Control/SelectButton2/SelectButton2Text.text = textOptionIndex[index].select2
	$Control/SelectButton3/SelectButton3Text.text = textOptionIndex[index].select3
	$Control/SelectButton1/SelectButtonSprite1.frame = 0
	$Control/SelectButton2/SelectButtonSprite2.frame = 0
	$Control/SelectButton3/SelectButtonSprite3.frame = 0
	transfering = false


# Creating loadbar animation and reseting its values
func _Transfer():
	$Control/ArchiveTransfer.visible = true
	
	while $Control/ArchiveTransfer/LoadBar.rect_size.x < 192:
		yield(get_tree().create_timer(0.01), "timeout");
		$Control/ArchiveTransfer/LoadBar.rect_size.x += 2
	
	$Control/ArchiveTransfer.visible = false
	$Control/ArchiveTransfer/LoadBar.rect_size.x = 0
	_NextChallenge()


# Function to changing buttons sprite
func _SelectButton(var index, var spriteIndex):
	var path = get_node("/root/Level 3/TasksSpawn/DataTask/Control/SelectButton" + spriteIndex + "/SelectButtonSprite" + spriteIndex)
	if path.frame == 0:
		path.frame = 1
		buttonSelecteds[index] = 1
	else:
		path.frame = 0
		buttonSelecteds[index] = 0


# Checking the buttons that are pressed
func _on_SelectButton1_pressed():
	_SelectButton(0, "1")


func _on_SelectButton2_pressed():
	_SelectButton(1, "2")


func _on_SelectButton3_pressed():
	_SelectButton(2, "3")



# Calling loadbar function
func _on_TransferButton_pressed():
	if taskChallenge <= 5 && !transfering:
		_Transfer()
		transfering = true


# Closing task
func _on_Close_Button_pressed():
	get_node("/root/Level 3/Player").canWalk = true
	get_node("/root/Level 3/Cenário 4").taskOcorring = false
	queue_free()


# Buttom to restart the task after failled
func _on_TryAgainButton_pressed():
	var task = Global.taskData.instance()
	get_node("/root/Level 3/TasksSpawn").add_child(task)
	queue_free()


# Closing task after completed
func _on_TaskFineshedButton_pressed():
	if !Global.dataTaskComplete:
			Global.dataTaskPoints[0] += 100
			Global.energy -= 1
			$Star.visible = true
			$TaskFineshed.visible = false
			Global.dataTaskComplete = true


# Closing task
func _on_TaskButtonClose_pressed():
	get_node("/root/Level 3/Player").canWalk = true
	get_node("/root/Level 3/Cenário 4").taskOcorring = false
	queue_free()


# Closing introduction screen
func _on_ButtonCloseIntroduction_pressed():
	$Control/SelectButton1.disabled = false
	$Control/SelectButton2.disabled = false
	$Control/SelectButton3.disabled = false
	$IntroductionScreen.queue_free()
