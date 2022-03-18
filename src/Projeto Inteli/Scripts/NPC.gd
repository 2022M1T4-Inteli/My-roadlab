extends Area2D

# Declaração de variaveis
var player = false
var fineshed = true
var dialogIndex = -1

#Variavel pública que pode ser acessada em outros scripts
export var dialog = ['Olá, seja bem-vindo(a) ao mundo das Indústrias Sun. Dirija-se aos andares\n 1 e 2 e realize os minijogos de Ciência da Computação e Engenharia de Computação, respectivamente.']

func _ready():
	# Definindo o que deve ser visivel ao iniciar o jogo e iniciando função
	$Button.visible = false
	get_node("/root/Level/DialogueBox").visible = false
	get_node("/root/Level/DialogueBox/Sprite").frame = 0
	$SpriteProx.visible = false

func _process(delta):
	# Chamando a função da caixa de dialogo se os casos forem verdadeiros
	if get_node("/root/Level/DialogueBox").visible && Input.is_action_just_pressed("ui_E") && dialogIndex < dialog.size() + 1 && fineshed:
		load_dialog()
		get_node("/root/Level/DialogueBox/Sprite").frame = 0
		fineshed = false

# Função para configurar a caixa de dialogo, criando a animação do texto e transição entre frases
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
		# Acessando variavel do node "Player" e alterando seus valores
		get_node("/root/Level/Player").canWalk = true
		$Button.visible = true
		get_node("/root/Level/DialogueBox").visible = false

func _physics_process(delta):
	# Definindo quando deve ser feita a transição entre o botão(E) e a caixa de dialogo
	# Iniciando caixa de dialogo
	if Input.is_action_just_pressed("ui_E") && player && !get_node("/root/Level/DialogueBox").visible:
		if $Button.visible == true:
			$Button.visible = false
			get_node("/root/Level/DialogueBox").visible = true
			#Acessando variaveis do node "Player", e alterando seus valores
			get_node("/root/Level/Player").canWalk = false
			#Inciando função da caixa de dialogo
			load_dialog()

# Checando se o jogador entrou na área e definindo o que deve ser visivel
func _on_NPC_body_entered(body):
	$Sprite.visible = false
	$SpriteProx.visible = true
	$Button.visible = true
	player = true

# Checando se o jogador saiu da área e definindo o que deve ser visivel
func _on_NPC_body_exited(body):
	$Button.visible = false
	$Sprite.visible = true
	$SpriteProx.visible = false
	player = false

# Criando animação da caixa de dialogo
func _on_Tween_tween_completed(object, key):
	get_node("/root/Level/DialogueBox/Sprite").frame = 1
	fineshed = true
