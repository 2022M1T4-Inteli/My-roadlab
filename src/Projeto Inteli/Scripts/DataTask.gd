# Made by Renato Machado
extends Node2D

# Declaring Variables
var buttonSelecteds = [0, 0, 0]
var correctAnswers = 0
var textTitleIndex = ["Desafio1", "Desafio2", "Desafio3", "Desafio4", "Desafio5", "Desafio6"]
var textOptionIndex = [{
	"select1": "Desafio1",
	"select2": "Desafio11",
	"select3": "Desafio111"},
	{
	"select1": "Desafio2",
	"select2": "Desafio22",
	"select3": "Desafio222"
	},
	{
	"select1": "Desafio3",
	"select2": "Desafio33",
	"select3": "Desafio333"
	},
	{
	"select1": "Desafio4",
	"select2": "Desafio44",
	"select3": "Desafio444"
	},
	{
	"select1": "Desafio5",
	"select2": "Desafio55",
	"select3": "Desafio555"
	},
	{
	"select1": "Desafio6",
	"select2": "Desafio66",
	"select3": "Desafio666"
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
			if buttonSelecteds[0] == 1 && buttonSelecteds[1] == 1 && buttonSelecteds[2] == 0:
				correctAnswers += 1
				_CheckingAnswers("1", 1)
				print("certo")
			else:
				_CheckingAnswers("1", 0)
				print("errado")
			_ResetingValues(1)
		1:
			if buttonSelecteds[0] == 0 && buttonSelecteds[1] == 0 && buttonSelecteds[2] == 1:
				correctAnswers += 1
				_CheckingAnswers("2", 1)
				print("certo")
			else:
				_CheckingAnswers("2", 0)
				print("errado")
			_ResetingValues(2)
		2:
			if buttonSelecteds[0] == 1 && buttonSelecteds[1] == 0 && buttonSelecteds[2] == 1:
				correctAnswers += 1
				_CheckingAnswers("3", 1)
				print("certo")
			else:
				_CheckingAnswers("3", 0)
				print("errado")
			_ResetingValues(3)
		3:
			if buttonSelecteds[0] == 1 && buttonSelecteds[1] == 1 && buttonSelecteds[2] == 0:
				correctAnswers += 1
				_CheckingAnswers("4", 1)
				print("certo")
			else:
				_CheckingAnswers("4", 0)
				print("errado")
			_ResetingValues(4)
		4:
			if buttonSelecteds[0] == 1 && buttonSelecteds[1] == 1 && buttonSelecteds[2] == 0:
				correctAnswers += 1
				_CheckingAnswers("5", 1)
				print("certo")
			else:
				_CheckingAnswers("5", 0)
				print("errado")
			_ResetingValues(5)
		5:
			if buttonSelecteds[0] == 1 && buttonSelecteds[1] == 1 && buttonSelecteds[2] == 0:
				correctAnswers += 1
				_CheckingAnswers("6", 1)
				print("certo")
			else:
				_CheckingAnswers("6", 0)
				print("errado")
			
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
			Global.pontos += 50
			Global.energy -= 1
			get_node("/root/Level 3/Player").canWalk = true
			get_node("/root/Level 3/Cenário 4").taskOcorring = false
			queue_free()
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
