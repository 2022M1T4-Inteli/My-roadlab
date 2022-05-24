# Writtem by Renato Machado
extends Node2D

# Declaring variables
var player = false
var advertised = false
export var level = ""


func _process(delta):
	# Checking if the energy eneded
	if Global.energy == 0 && !advertised:
		$OutOfEnergy.visible = true
		advertised = true

	# Changing sprite frame according the amount of energy
	match Global.energy:
		3:
			$HudEnergia.frame = 0
		2:
			$HudEnergia.frame = 1
		1:
			$HudEnergia.frame = 2
		0:
			$HudEnergia.frame = 3
	
	# Openimg coffee shop interface
	if player && Input.is_action_just_pressed("ui_E") || player && Global.ePressed:
		$Control.visible = true
		get_node("/root/" + level + "/Player").canWalk = false
		get_node("/root/" + level + "/Player/Sprite").visible = false


# Checkingp if the player is in area
func _on_Area2D_body_entered(body):
	player = true
	$HudEnergia/Area2D/Sprite.frame = 1
	$HudEnergia/Area2D/Button.visible = true

# Checking is the player isn't in area
func _on_Area2D_body_exited(body):
	player = false
	$HudEnergia/Area2D/Sprite.frame = 0
	$HudEnergia/Area2D/Button.visible = false


# Closing coffee shop interface
func _on_CloseButton_pressed():
	$Control.visible = false
	get_node("/root/" + level + "/Player").canWalk = true
	get_node("/root/" + level + "/Player/Sprite").visible = true


func _on_AdvertiseButton_pressed():
	$EnergyAdvertise.visible = false


func _on_OutOfEnergyCloseButton_pressed():
	$OutOfEnergy.visible = false


# Buying coffee
func _on_BuyButton_pressed():
	if Global.energy != 3 && Global.points >= 50:
		Global.moneySpend += 50
		Global.energy = 3
	elif Global.energy == 3:
		print("energia cheia")
		$EnergyAdvertise.visible = true
	elif Global.points < 50:
		print("dinheiro insuficiente")
