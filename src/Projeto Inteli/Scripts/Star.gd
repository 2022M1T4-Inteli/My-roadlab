# Writed by Renato Machado
extends Control

# Declaring variables
var selected = false
var index = 0
export var taskName = ""
export var levelNumber = 0
export var taskIndex = 0


# Setting star values to correct variable
func _SetStarPoints(var starNumber):
	match starNumber:
		1:
			Global.satelliteTaskPoints[1] = index
		2:
			Global.describingTaskPoints[1] = index
		3:
			Global.computerTaskPoints[1] = index
		4:
			Global.dataTaskPoints[1] = index
		5:
			Global.automationTestTaskPoints[1] = index


# Checking where is the mouse and selecting star value
func _on_StarButton1_mouse_entered():
	$Estrelas.frame = 1


func _on_StarButton1_mouse_exited():
	$Estrelas.frame = index


func _on_StarButton1_pressed():
	$Estrelas.frame = 1
	index = 1


func _on_StarButton2_mouse_entered():
	$Estrelas.frame = 2


func _on_StarButton2_mouse_exited():
	$Estrelas.frame = index


func _on_StarButton2_pressed():
	$Estrelas.frame = 2
	index = 2


func _on_StarButton3_mouse_entered():
	$Estrelas.frame = 3


func _on_StarButton3_mouse_exited():
	$Estrelas.frame = index


func _on_StarButton3_pressed():
	$Estrelas.frame = 3
	index = 3


func _on_StarButton4_mouse_entered():
	$Estrelas.frame = 4


func _on_StarButton4_mouse_exited():
	$Estrelas.frame = index


func _on_StarButton4_pressed():
	$Estrelas.frame = 4
	index = 4


func _on_StarButton5_mouse_entered():
	$Estrelas.frame = 5


func _on_StarButton5_mouse_exited():
	$Estrelas.frame = index


func _on_StarButton5_pressed():
	$Estrelas.frame = 5
	index = 5


# Closing task
func _on_OkButton_pressed():
	_SetStarPoints(taskIndex)
	get_node("/root/Level " + str(levelNumber) + "/Player").canWalk = true
	get_node("/root/Level " + str(levelNumber) + "/Cenário " + str(levelNumber + 1)).taskOcorring = false
	get_node("/root/Level " + str(levelNumber) + "/TasksSpawn/" + taskName).queue_free()
