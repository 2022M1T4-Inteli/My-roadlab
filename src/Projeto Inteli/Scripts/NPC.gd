# Made by Renato Machado
extends Area2D

# Declaring variables
var player = false
var fineshed = true
var dialogIndex = -1

#Public variable that can be accessed out of script
var dialog = ["Seja bem-vindo(a) a nossa indústria, hoje você irá começar como nosso\n estagiário em tecnologia. Atualmente, possuímos quatro setores divididos em andares, sendo eles:",
				"1º Andar - Ciência da computação\n2º Andar - Engenharia da Computação\n3º Andar - Sistema da Informação\n4º Andar - Engenharia de Software",
				"Ande pelos andares explorando as atividades que nossos desenvolvedores\ntêm trabalhado e auxilie-os em suas tarefas diárias. Em cada tarefa você\nreceberá uma quantidade de moeda referente ao serviço prestado."]


func _ready():
	# Defining what can be visible when the game start
	$Button.visible = false
	get_node("/root/Level/DialogueBox").visible = false
	get_node("/root/Level/DialogueBox/Sprite").frame = 0
	$SpriteProx.visible = false


func _process(delta):
	# Calling the function to start the dialog box if all the cases are true
	if get_node("/root/Level/DialogueBox").visible && Input.is_action_just_pressed("ui_E") && dialogIndex < dialog.size() + 1 && fineshed:
		load_dialog()
		get_node("/root/Level/DialogueBox/Sprite").frame = 0
		fineshed = false


# Function to configure the dialog box, creating the text animation and transiting through index
func load_dialog():
	if dialogIndex < dialog.size():
		get_node("/root/Level/DialogueBox/RichTextLabel").bbcode_text = dialog[dialogIndex]
		get_node("/root/Level/DialogueBox/RichTextLabel").percent_visible = 0
#		yield(get_tree().create_timer(.5), "timeout")
		$Tween.interpolate_property(get_node("/root/Level/DialogueBox/RichTextLabel"), "percent_visible", 0, 1, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		dialogIndex += 1
	else:
		dialogIndex = 0
		get_node("/root/Level/DialogueBox/RichTextLabel").bbcode_text = dialog[dialogIndex]
		# Accessing variable of other node("Player") and changing its values
		get_node("/root/Level/Player").canWalk = true
		$Button.visible = true
		get_node("/root/Level/DialogueBox").visible = false


func _physics_process(delta):
	# Defining when the trasition will occur between the button and the dialog box
	# Starting dialog box
	if Input.is_action_just_pressed("ui_E") && player && !get_node("/root/Level/DialogueBox").visible:
		if $Button.visible == true:
			$Button.visible = false
			get_node("/root/Level/DialogueBox").visible = true
			#Accessing varibles of other node("Player") and changing its values
			get_node("/root/Level/Player").canWalk = false
			#Starting dialog box's function
			load_dialog()


# Checking if the player is in area
func _on_NPC_body_entered(body):
	$Sprite.visible = false
	$SpriteProx.visible = true
	$Button.visible = true
	player = true

# Checking if the player left the area
func _on_NPC_body_exited(body):
	$Button.visible = false
	$Sprite.visible = true
	$SpriteProx.visible = false
	player = false

# Changing dialog box's sprite frame
func _on_Tween_tween_completed(object, key):
	get_node("/root/Level/DialogueBox/Sprite").frame = 1
	fineshed = true
