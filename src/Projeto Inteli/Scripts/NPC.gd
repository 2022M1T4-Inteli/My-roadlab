# Writed by Renato Machado
extends Area2D

# Declaring variables
var player = false
var fineshed = true
var dialogIndex = -1
var dialog = []

# Publics variables that can be accessed out of script
export var spriteType = 0
export var level = ""

var npcSpriteArray = [preload("res://Sprites/Npc/OlhoParado.png"), 
								preload("res://Sprites/Npc/OlhoParadoInRange.png"), 
								preload("res://Sprites/Npc/CuboParado.png"),
								preload("res://Sprites/Npc/CuboParadoInRange.png")]


# Function to set NPC's sprites
func _ChooseSprite():
	match spriteType:
		0:
			$Sprite.texture = npcSpriteArray[0]
			$SpriteProx.texture = npcSpriteArray[1]
		1:
			$Sprite.texture = npcSpriteArray[2]
			$SpriteProx.texture = npcSpriteArray[3]
			$Sprite.position += Vector2(0, -1)
			$SpriteProx.position += Vector2(0, -1)


# Function to set dialog text
func _ChooseDiologueIndex():
	match level:
		"Level":
			$Sprite.scale = Vector2(-1, 1)
			$SpriteProx.scale = Vector2(-1, 1)
			_ChooseSprite()
			dialog = ["Seja bem-vindo(a) ao prédio das Indústrias Habimorad & Santoro - um \nconglomerado de tecnologia e inovação com atuação internacional. \nAqui, são desenvolvidos equipamentos e softwares de ponta que são \nfornecidos à sociedade com foco nas mais diversas áreas da ciência.",
					"Um momento... Estou verificando a sua identidade para prosseguirmos.",
					"Você foi contratado como estagiário e o seu objetivo é receber as horas \nnecessárias para graduar-se em seu curso técnico e iniciar sua \nfaculdade. Não se preocupe: assim que cumprir suas obrigações e \ntarefas aqui, você terá uma boa ideia do que cursar no ensino superior.",
					"Atualmente, possuímos quatro setores divididos em andares, sendo eles:",
					"1º Andar - Ciência da computação\n2º Andar - Engenharia da Computação\n3º Andar - Sistema da Informação\n4º Andar - Engenharia de Software",
					"Ande pelos andares explorando as atividades que nossos desenvolvedores\ntêm trabalhado e auxilie-os em suas tarefas diárias. Em cada tarefa você\nreceberá uma quantidade de moeda referente ao serviço prestado.",
					"Boa sorte e muito sucesso, até mais! :-)"]
		"Level 1":
			_ChooseSprite()
			dialog = ["Você está no setor de Ciência da Computação (1º andar). Essa grande \nárea nasceu de um dispositivo teórico conhecido como máquina universal - um modelo abstrato de computador criado por Alan Turing."]
		"Level 2":
			_ChooseSprite()
			dialog = ["Você está no setor de Engenharia da Computação (2º andar). Essa grande \nárea nasceu da imaginação de uma máquina (o computador) por Charles Babbage."]
		"Level 3":
			_ChooseSprite()
			dialog = ["Você está no setor de Sistemas de Informação (3º andar). Aqui utilizamos \ndados para criar soluções relevantes e eficientes."]
		"Level 4":
			_ChooseSprite()
			dialog = ["Você está no setor de Engenharia de Software (4º andar). Aqui utilizamos as \nferramentas desenvolvidas pelos outros setores e criamos ambientes \nde trabalho que viabilizam a criação e gestão de novas tecnologias."]


func _ready():
	# Defining what can be visible when the game start
	_ChooseDiologueIndex()
	$Button.visible = false
	get_node("/root/" + level + "/DialogueBox").visible = false
	get_node("/root/" + level + "/DialogueBox/Sprite").frame = 0
	$SpriteProx.visible = false


func _process(delta):
	# Calling the function to start the dialog box if all the cases are true
	if get_node("/root/" + level + "/DialogueBox").visible && Input.is_action_just_pressed("ui_E") && dialogIndex < dialog.size() + 1 && fineshed:
		load_dialog()
		get_node("/root/" + level + "/DialogueBox/Sprite").frame = 0
		fineshed = false


# Function to configure the dialog box, creating the text animation and transiting through index
func load_dialog():
	if dialogIndex < dialog.size():
		get_node("/root/" + level + "/DialogueBox/RichTextLabel").bbcode_text = dialog[dialogIndex]
		get_node("/root/" + level + "/DialogueBox/RichTextLabel").percent_visible = 0
#		yield(get_tree().create_timer(.5), "timeout")
		$Tween.interpolate_property(get_node("/root/" + level + "/DialogueBox/RichTextLabel"), "percent_visible", 0, 1, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		dialogIndex += 1
	else:
		dialogIndex = 0
		get_node("/root/" + level + "/DialogueBox/RichTextLabel").bbcode_text = dialog[dialogIndex]
		# Accessing variable of other node("Player") and changing its values
		get_node("/root/" + level + "/Player").canWalk = true
		$Button.visible = true
		get_node("/root/" + level + "/DialogueBox").visible = false


func _physics_process(delta):
	# Defining when the trasition will occur between the button and the dialog box
	# Starting dialog box
	if Input.is_action_just_pressed("ui_E") && player && !get_node("/root/" + level + "/DialogueBox").visible:
		if $Button.visible == true:
			$Button.visible = false
			get_node("/root/" + level + "/DialogueBox").visible = true
			#Accessing varibles of other node("Player") and changing its values
			get_node("/root/" + level + "/Player").canWalk = false
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
	get_node("/root/" + level + "/DialogueBox/Sprite").frame = 1
	fineshed = true
