extends Area2D

#Declaração de variaveis
var player = false
var floorSelect = false

onready var animationTree = $AnimationTree
onready var stateMachine = animationTree.get("parameters/playback")

func _ready():
	#Definindo o que deve ser visivel inicialmente
	$Button.visible = false

func _process(delta):
	#Abrindo intereface de seleção de andar e inciando animação do elevador abrir
	if player && Input.is_action_pressed("ui_E"):
		stateMachine.travel("Abrindo")
		#Acessando variaveis do node "Player", e alterando seus valores
		get_node("/root/Level/Player").canWalk = false
		get_node("/root/Level/Player").stateMachine.travel("Idle")
		floorSelect = true
	#Fechando inteface de seleção de andar e retornando o elevador a animação padrão
	if floorSelect && Input.is_action_pressed("ui_cancel"):
		#Acessando variaveis do node "Player", e alterando seus valores
		get_node("/root/Level/Player").canWalk = true
		stateMachine.travel("Fechar")

func _on_Elevador_body_entered(body):
	#checando se o jogador entrou na área e alterando animação
	stateMachine.travel("Abrir")
	player = true
	$Button.visible = true

func _on_Elevador_body_exited(body):
	#checando se o jogador saiu da área e alterando animação
	player = false
	stateMachine.travel("Idle")
	$Button.visible = false
