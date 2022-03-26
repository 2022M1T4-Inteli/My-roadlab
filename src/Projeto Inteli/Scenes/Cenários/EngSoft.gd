extends Sprite


# Declaring variable
var playerAutomationTest = false
var taskAutomationTeste = preload("res://Scenes/Tasks/TestAutomationTask.tscn")
var taskOcorring = false


func _process(delta):
	# Starting task after interct with button "E" and the player is in area
	if playerAutomationTest && Input.is_action_just_pressed("ui_E") && !taskOcorring && !Global.automationTestTaskComplete:
		var task = taskAutomationTeste.instance()
		get_node("/root/Level 4/TasksSpawn").add_child(task)
#		$DescribingTask/Button.visible = false
#		$DescribingTask/Sprite.frame = 0
		get_node("/root/Level 4/Player").canWalk = false
		taskOcorring = true
	if !taskOcorring && playerAutomationTest && !Global.automationTestTaskComplete:
#		$DescribingTask/Sprite.frame = 1
#		$DescribingTask/Button.visible = true
		pass


func _on_AutomationTesteTaskArea_body_entered(body):
	if !Global.describingTaskComplete:
		playerAutomationTest = true
#		$DescribingTask/Sprite.frame = 1
#		$DescribingTask/Button.visible = true


func _on_AutomationTesteTaskArea_body_exited(body):
	playerAutomationTest = false
#	$DescribingTask/Sprite.frame = 0
#	$DescribingTask/Button.visible = false
