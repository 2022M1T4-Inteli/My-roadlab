# Made by Renato Machado
extends Node2D

var playerData = false
var taskData = preload("res://Scenes/Tasks/DataTask.tscn")
var taskOcorring = false


func _process(delta):
	# Starting task after interct with button "E" and the player is in area
	if playerData && Input.is_action_just_pressed("ui_E") && !taskOcorring && !Global.dataTaskComplete && Global.energy > 0:
		var task = taskData.instance()
		get_node("/root/Level 3/TasksSpawn").add_child(task)
#		$DescribingTask/Button.visible = false
#		$DescribingTask/Sprite.frame = 0
		get_node("/root/Level 3/Player").canWalk = false
		taskOcorring = true
#	if !taskOcorring && playerData && !Global.dataTaskComplete:
#		$DescribingTask/Sprite.frame = 1
#		$DescribingTask/Button.visible = true


# Checking if the player left the area
func _on_DataTask_body_entered(body):
	if !Global.dataTaskComplete:
		playerData = true
#		$DescribingTask/Sprite.frame = 1
#		$DescribingTask/Button.visible = true

# Checking if the player is area
func _on_DataTask_body_exited(body):
	playerData = false
#	$DescribingTask/Sprite.frame = 0
#	$DescribingTask/Button.visible = false

