extends Control

# Declaring variables
var op1 = false
var op2 = false
var op3 = false
var op4 = false

func _ready():
	if !Global.introduction:
		get_node("/root/Level/Player/Sprite").scale = Vector2(1, 1)


# Making trasintion between animations
func _process(delta):
	if Global.introduction:
		get_node("/root/Level/Manual").queue_free()
		get_node("/root/Level/Player").canWalk = true
		get_node("/root/Level/Player").position = Vector2(573, 263)
		queue_free()
	
	if op1:
		$Sprite.frame = 1
	elif op2:
		$Sprite.frame = 2
	elif op3:
		$Sprite.frame = 3
	elif op4:
		$Sprite.frame = 4
	else:
		$Sprite.frame = 0


# Defining which sprite the player choosed
func _on_Op1_pressed():
	Global.sprNumber = 0
	get_node("/root/Level/Manual").visible = true
	get_node("/root/Level/Seleção de Personagem").queue_free()


func _on_Op2_pressed():
	Global.sprNumber = 1
	get_node("/root/Level/Manual").visible = true
	get_node("/root/Level/Seleção de Personagem").queue_free()


func _on_Op3_pressed():
	Global.sprNumber = 2
	get_node("/root/Level/Manual").visible = true
	get_node("/root/Level/Seleção de Personagem").queue_free()


func _on_Op4_pressed():
	Global.sprNumber = 3
	get_node("/root/Level/Manual").visible = true
	get_node("/root/Level/Seleção de Personagem").queue_free()


# Checking if the mouse is on top of any button
func _on_Op1_mouse_entered():
	op1 = true


func _on_Op1_mouse_exited():
	op1 = false


func _on_Op2_mouse_entered():
	op2 = true


func _on_Op2_mouse_exited():
	op2 = false


func _on_Op3_mouse_entered():
	op3 = true


func _on_Op3_mouse_exited():
	op3 = false


func _on_Op4_mouse_entered():
	op4 = true


func _on_Op4_mouse_exited():
	op4 = false
