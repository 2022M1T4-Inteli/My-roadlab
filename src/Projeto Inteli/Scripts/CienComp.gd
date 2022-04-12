# Writed by Renato Machado
extends Node2D

# Declaring variable
var playerDescribing = false
var taskDescribing = preload("res://Scenes/Tasks/DescribingTask.tscn")
var taskOcorring = false


func _process(delta):
	# Starting task after interct with button "E" and the player is in area
	if playerDescribing && Input.is_action_just_pressed("ui_E") && !taskOcorring && !Global.describingTaskComplete && Global.energy > 0 || playerDescribing && Global.ePressed && !taskOcorring && !Global.describingTaskComplete && Global.energy > 0:
		var task = taskDescribing.instance()
		get_node("/root/Level 1/TasksSpawn").add_child(task)
		$DescribingTask/Button.visible = false
		$DescribingTask/Sprite.frame = 0
		get_node("/root/Level 1/Player").canWalk = false
		taskOcorring = true
	if !taskOcorring && playerDescribing && !Global.describingTaskComplete:
		$DescribingTask/Sprite.frame = 1
		$DescribingTask/Button.visible = true


# Checking if the player left the area
func _on_DescribingTask_body_exited(body):
	playerDescribing = false
	$DescribingTask/Sprite.frame = 0
	$DescribingTask/Button.visible = false

# Checking if the player is area
func _on_DescribingTask_body_entered(body):
	if !Global.describingTaskComplete:
		playerDescribing = true
		$DescribingTask/Sprite.frame = 1
		$DescribingTask/Button.visible = true
