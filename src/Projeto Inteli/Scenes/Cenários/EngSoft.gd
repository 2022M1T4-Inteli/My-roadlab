extends Sprite


# Declaring variable
var playerAutomationTest = false
var taskAutomationTeste = preload("res://Scenes/Tasks/TestAutomationTask.tscn")
var taskOcorring = false


func _process(delta):
	# Starting task after interct with button "E" and the player is in area
	if playerAutomationTest && Input.is_action_just_pressed("ui_E") && !taskOcorring && !Global.automationTestTaskComplete && Global.energy > 0:
		var task = taskAutomationTeste.instance()
		get_node("/root/Level 4/TasksSpawn").add_child(task)
		$AutomationTesteTaskArea/Button.visible = false
		$AutomationTesteTaskArea/Sprite.frame = 0
		get_node("/root/Level 4/Player").canWalk = false
		taskOcorring = true
	if !taskOcorring && playerAutomationTest && !Global.automationTestTaskComplete:
		$AutomationTesteTaskArea/Sprite.frame = 1
		$AutomationTesteTaskArea/Button.visible = true
		pass


# Checking if the player is in the area
func _on_AutomationTesteTaskArea_body_entered(body):
	if !Global.automationTestTaskComplete:
		playerAutomationTest = true
		$AutomationTesteTaskArea/Sprite.frame = 1
		$AutomationTesteTaskArea/Button.visible = true


# Checking if the player left the area
func _on_AutomationTesteTaskArea_body_exited(body):
	playerAutomationTest = false
	$AutomationTesteTaskArea/Sprite.frame = 0
	$AutomationTesteTaskArea/Button.visible = false
