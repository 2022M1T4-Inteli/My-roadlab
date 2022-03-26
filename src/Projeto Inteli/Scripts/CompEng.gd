extends Node2D

# Declaring variable
var playerSatellite = false
var playerComputer = false
var taskSatellite = preload("res://Scenes/Tasks/SatelliteTask.tscn")
var taskComputer = preload("res://Scenes/Tasks/ComputerTask.tscn")
var taskOcorring = false


func _process(delta):
	# Starting task after interct with button "E" and the player is in area
	if playerSatellite && Input.is_action_just_pressed("ui_E") && !taskOcorring && !Global.satelliteTaskComplete:
		var task = taskSatellite.instance()
		get_node("/root/Level 2/TasksSpawn").add_child(task)
		$SatelliteTaskArea/Button.visible = false
		$SatelliteTaskArea/Sprite.frame = 0
		get_node("/root/Level 2/Player").canWalk = false
		taskOcorring = true
	
	if playerComputer && Input.is_action_just_pressed("ui_E") && !taskOcorring && !Global.computerTaskComplete:
		var task = taskComputer.instance()
		get_node("/root/Level 2/TasksSpawn").add_child(task)
		get_node("/root/Level 2/Player").canWalk = false
		taskOcorring = true


func _restart():
	get_node("/root/Level 2/Player").canWalk = true
	$SatelliteTaskArea/Button.visible = true
	$SatelliteTaskArea/Sprite.frame = 1
	taskOcorring = false


# Checking if the player is in area
func _on_SatelliteTaskArea_body_entered(body):
	if !Global.satelliteTaskComplete:
		$SatelliteTaskArea/Button.visible = true
		$SatelliteTaskArea/Sprite.frame = 1
		playerSatellite = true


# Checking if the player left the area
func _on_SatelliteTaskArea_body_exited(body):
	$SatelliteTaskArea/Button.visible = false
	$SatelliteTaskArea/Sprite.frame = 0
	playerSatellite = false


func _on_ComputerTaskArea_body_entered(body):
	if !Global.computerTaskComplete:
		playerComputer = true


func _on_ComputerTaskArea_body_exited(body):
	playerComputer = false
