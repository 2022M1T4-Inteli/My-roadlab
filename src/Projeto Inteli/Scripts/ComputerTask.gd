extends Node2D


func _process(delta):
	if Global.totalComputer >= 6:
		get_node("/root/Level 2/TasksSpawn/Computer Task/TaskFineshed").visible = true
		get_node("/root/Level 2/TasksSpawn/Computer Task/Control/Button").visible = false
		if !Global.computerTaskComplete:
			Global.pontos += 50
		Global.computerTaskComplete = true
		get_node("/root/Level 2/Player").canWalk = true
		get_node("/root/Level 2/Cenário 3").taskOcorring = false


func _on_Button_pressed():
	Global.totalComputer = 0
	get_node("/root/Level 2/Player").canWalk = true
	get_node("/root/Level 2/Cenário 3").taskOcorring = false
	queue_free()


func _on_TaskFineshedButton_pressed():
	Global.totalComputer = 0
	queue_free()
