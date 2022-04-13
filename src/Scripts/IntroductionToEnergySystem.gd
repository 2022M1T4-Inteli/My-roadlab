# Writed by Renato Machado
extends Control

# Closing introduction 
func _on_Button_pressed():
	get_node("/root/Level/Player").canWalk = true
	self.queue_free()
