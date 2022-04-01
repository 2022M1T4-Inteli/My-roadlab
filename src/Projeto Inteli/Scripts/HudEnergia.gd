# Made by Renato Machado
extends Sprite

# Declaring variables
var player = false
var advertised = false


func _process(delta):
	# Checking if the energy eneded
	if Global.energy == 0 && !advertised:
		get_node("../OutOfEnergy").visible = true
		advertised = true
		
	
	# Changing sprite frame according the amount of energy
	match Global.energy:
		3:
			self.frame = 0
		2:
			self.frame = 1
		1:
			self.frame = 2
		0:
			self.frame = 3
	
	# Openimg coffee shop interface
	if player && Input.is_action_just_pressed("ui_E"):
		$Control.visible = true
		get_node("../Player").canWalk = false


# Checkingp if the player is in area
func _on_Area2D_body_entered(body):
	player = true
	$Area2D/Sprite.frame = 1
	$Area2D/Button.visible = true

# Checking is the player isn't in area
func _on_Area2D_body_exited(body):
	player = false
	$Area2D/Sprite.frame = 0
	$Area2D/Button.visible = false


# Buying coffee
func _on_Button_pressed():
	if Global.energy != 3 && Global.pontos >= 50:
		Global.pontos -= 50
		Global.energy = 3
	elif Global.energy == 3:
		print("energia cheia")
		$EnergyAdvertise.visible = true
	elif Global.pontos < 50:
		print("dinheiro insuficiente")


# Closing coffee shop interface
func _on_CloseButton_pressed():
	$Control.visible = false
	get_node("../Player").canWalk = true


func _on_AdvertiseButton_pressed():
	$EnergyAdvertise.visible = false


func _on_OutOfEnergyCloseButton_pressed():
	get_node("../OutOfEnergy").visible = false
