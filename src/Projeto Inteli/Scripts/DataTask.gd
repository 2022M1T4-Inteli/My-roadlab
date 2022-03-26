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
	$Control/ChallengeTitle.text = textTitleIndex[0]
	$Control/SelectButton1/SelectButton1Text.text = textOptionIndex[0].select1
	$Control/SelectButton2/SelectButton2Text.text = textOptionIndex[0].select2
	$Control/SelectButton3/SelectButton3Text.text = textOptionIndex[0].select3


func _FineshedAllSteps():
	if correctAnswers >= 5:
		$TaskFineshed.visible = true
		$Control/TaskButtonClose.visible = false
	else:
		$TaskRetry.visible = true
	pass


func _NextChallenge():
	match taskChallenge:
		0:
			if buttonSelecteds[0] == 1 && buttonSelecteds[1] == 1 && buttonSelecteds[2] == 0:
				correctAnswers += 1
				print("certo")
			else:
				print("errado")
			_ResetingValues(1)
		1:
			if buttonSelecteds[0] == 0 && buttonSelecteds[1] == 0 && buttonSelecteds[2] == 1:
				correctAnswers += 1
				print("certo")
			else:
				print("errado")
			_ResetingValues(2)
		2:
			if buttonSelecteds[0] == 1 && buttonSelecteds[1] == 0 && buttonSelecteds[2] == 1:
				correctAnswers += 1
				print("certo")
			else:
				print("errado")
			_ResetingValues(3)
		3:
			if buttonSelecteds[0] == 1 && buttonSelecteds[1] == 1 && buttonSelecteds[2] == 0:
				correctAnswers += 1
				print("certo")
			else:
				print("errado")
			_ResetingValues(4)
		4:
			if buttonSelecteds[0] == 1 && buttonSelecteds[1] == 1 && buttonSelecteds[2] == 0:
				correctAnswers += 1
				print("certo")
			else:
				print("errado")
			_ResetingValues(5)
		5:
			if buttonSelecteds[0] == 1 && buttonSelecteds[1] == 1 && buttonSelecteds[2] == 0:
				correctAnswers += 1
				print("certo")
			else:
				print("errado")
			
			_FineshedAllSteps()
			pass


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


func _SelectButton(var index, var spriteIndex):
	if get_node("/root/Level 3/TasksSpawn/DataTask/Control/SelectButton" + spriteIndex + "/SelectButtonSprite" + spriteIndex).frame == 0:
		get_node("/root/Level 3/TasksSpawn/DataTask/Control/SelectButton" + spriteIndex + "/SelectButtonSprite" + spriteIndex).frame = 1
		buttonSelecteds[index] = 1
	else:
		get_node("/root/Level 3/TasksSpawn/DataTask/Control/SelectButton" + spriteIndex + "/SelectButtonSprite" + spriteIndex).frame = 0
		buttonSelecteds[index] = 0


func _on_SelectButton1_pressed():
	_SelectButton(0, "1")


func _on_SelectButton2_pressed():
	_SelectButton(1, "2")


func _on_SelectButton3_pressed():
	_SelectButton(2, "3")


func _on_TransferButton_pressed():
	if taskChallenge <= 5 && !transfering:
		_Transfer()
		transfering = true


func _on_Close_Button_pressed():
	get_node("/root/Level 3/Player").canWalk = true
	get_node("/root/Level 3/Cenário 4").taskOcorring = false
	queue_free()


func _on_TryAgainButton_pressed():
	var task = Global.taskData.instance()
	get_node("/root/Level 3/TasksSpawn").add_child(task)
	queue_free()


func _on_TaskFineshedButton_pressed():
	if !Global.dataTaskComplete:
			Global.pontos += 50
			get_node("/root/Level 3/Player").canWalk = true
			get_node("/root/Level 3/Cenário 4").taskOcorring = false
			queue_free()
			Global.dataTaskComplete = true


func _on_TaskButtonClose_pressed():
	get_node("/root/Level 3/Player").canWalk = true
	get_node("/root/Level 3/Cenário 4").taskOcorring = false
	queue_free()
