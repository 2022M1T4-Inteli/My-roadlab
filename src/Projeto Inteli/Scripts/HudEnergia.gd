# Made by Renato Machado
extends Sprite

var player = false


func _process(delta):
	match Global.energy:
		3:
			self.frame = 0
		2:
			self.frame = 1
		1:
			self.frame = 2
		0:
			self.frame = 3
	
	if player && Input.is_action_just_pressed("ui_E"):
		$Control.visible = true
		get_node("../Player").canWalk = false


func _on_Area2D_body_entered(body):
	player = true
	$Area2D/Sprite.frame = 1
	$Area2D/Button.visible = true


func _on_Area2D_body_exited(body):
	player = false
	$Area2D/Sprite.frame = 0
	$Area2D/Button.visible = false


func _on_Button_pressed():
	if Global.energy < 3:
		Global.pontos -= 50
		Global.energy = 3


func _on_CloseButton_pressed():
	$Control.visible = false
	get_node("../Player").canWalk = true
