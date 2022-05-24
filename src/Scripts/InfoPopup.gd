# Writtem by Renato Machado
extends Control

func _on_CloseButton_pressed():
	
	# Setting up the info popup as invisible.
	self.visible = false;
	
	# Enabling all task buttons.
	get_node("/root/Level 4/TasksSpawn/Root/Task/CloseTaskButton").disabled = false;
	get_node("/root/Level 4/TasksSpawn/Root/Task/CorrectOutputButton").disabled = false;
	get_node("/root/Level 4/TasksSpawn/Root/Task/IncorrectOutputButton").disabled = false;
	
	# Starting the task timer.
	get_node("/root/Level 4/TasksSpawn/Root/Task").startTaskTimer();
	
