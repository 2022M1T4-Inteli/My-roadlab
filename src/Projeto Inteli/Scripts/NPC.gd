extends Area2D

#Declaração de variaveis
var player = false
var fineshed = true

var dialog = ['Olá, seja bem vindo!\nIrei ajuda-lo daqui pra frente.']
var dialogIndex = 0

func _ready():
	#Definindo o que deve ser visivel ao iniciar o jogo e iniciando função
	$Button.visible = false
	$DialogueBox.visible = false
	$SpriteProx.visible = false
	$DialogueBox/Sprite.frame = 0
	

func _process(delta):
	#Iniciando função
	if Input.is_action_just_pressed("ui_accept") && $DialogueBox.visible && dialogIndex < dialog.size() + 1 && fineshed:
		load_dialog()
		$DialogueBox/Sprite.frame = 0
		fineshed = false

#Função para configurar a caixa de dialogo, criando a animação do texto e transição entre frases
func load_dialog():
	if dialogIndex < dialog.size():
		$DialogueBox/RichTextLabel.bbcode_text = dialog[dialogIndex]
		$DialogueBox/RichTextLabel.percent_visible = 0
#		yield(get_tree().create_timer(.5), "timeout")
		$Tween.interpolate_property($DialogueBox/RichTextLabel, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		dialogIndex += 1
	else:
		dialogIndex = 0
		$DialogueBox/RichTextLabel.bbcode_text = dialog[dialogIndex]
		$Button.visible = true
		$DialogueBox.visible = false
	

func _physics_process(delta):
	#Definindo quando deve ser feita a transição entre o botão(E) e a caixa de dialogo
	#Iniciando caixa de dialogo
	if Input.is_action_just_pressed("ui_E") && player && !$DialogueBox.visible:
		if $Button.visible == true:
			$Button.visible = false
			$DialogueBox.visible = true
			load_dialog()
		else:
			$Button.visible = true
			$DialogueBox.visible = false

#Checando se o jogador entrou na área e definindo o que deve ser visivel
func _on_NPC_body_entered(body):
	$Sprite.visible = false
	$SpriteProx.visible = true
	$Button.visible = true
	player = true

#Checando se o jogador saiu da área e definindo o que deve ser visivel
func _on_NPC_body_exited(body):
	$Button.visible = false
	$Sprite.visible = true
	$SpriteProx.visible = false
	player = false

#Criando animação da caixa de dialogo
func _on_Tween_tween_completed(object, key):
	$DialogueBox/Sprite.frame = 1
	fineshed = true
