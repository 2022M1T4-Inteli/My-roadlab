extends Area2D

# Declaração de variaveis
var player = false
var floorSelect = false
var _floor = 0

onready var animationTree = $AnimationTree
onready var stateMachine = animationTree.get("parameters/playback")

func _ready():
	# Definindo o que deve ser visivel inicialmente
	$ElevadorInterface0.visible = false
	$Button.visible = false

func _process(delta):
	# Abrindo intereface de seleção de andar e inciando animação do elevador abrir
	if player && Input.is_action_pressed("ui_E"):
		stateMachine.travel("Abrindo")
		$ElevadorInterface0.visible = true
		#Acessando variaveis do node "Player", e alterando seus valores
		get_node("/root/Level/Player").canWalk = false
		floorSelect = true
	# Fechando inteface de seleção de andar e retornando o elevador a animação padrão
	if floorSelect && Input.is_action_pressed("ui_cancel"):
		#Acessando variaveis do node "Player", e alterando seus valores
		$ElevadorInterface0.visible = false
		floorSelect = false
		get_node("/root/Level/Player").canWalk = true
		stateMachine.travel("Fechar")

func _on_Elevador_body_entered(body):
	# checando se o jogador entrou na área e alterando animação
	stateMachine.travel("Abrir")
	player = true
	$Button.visible = true

func _on_Elevador_body_exited(body):
	# checando se o jogador saiu da área e alterando animação
	player = false
	stateMachine.travel("Idle")
	$Button.visible = false

# Fechando interface do elevador.
func _on_ButtonFechar_pressed():
	$ElevadorInterface0.visible = false
	floorSelect = false
	get_node("/root/Level/Player").canWalk = true
	stateMachine.travel("Fechar")


# Checando qual botão foi pressionado, para trocar de andar
func _on_ButtonAndar1_pressed():
	pass

func _on_ButtonAndar2_pressed():
	pass

func _on_ButtonAndar3_pressed():
	pass

func _on_ButtonAndar4_pressed():
	pass

func _on_ButtonAndar5_pressed():
	pass


# Checando se o mouse está em cima de alguns dos botões
func _on_ButtonAndar1_mouse_entered():
	$ElevadorInterface0/Botoes.frame = 1      
func _on_ButtonAndar1_mouse_exited():
	$ElevadorInterface0/Botoes.frame = 0

func _on_ButtonAndar2_mouse_entered():
	$ElevadorInterface0/Botoes.frame = 2
func _on_ButtonAndar2_mouse_exited():
	$ElevadorInterface0/Botoes.frame = 0

func _on_ButtonAndar3_mouse_entered():
	$ElevadorInterface0/Botoes.frame = 3
func _on_ButtonAndar3_mouse_exited():
	$ElevadorInterface0/Botoes.frame = 0  

func _on_ButtonAndar4_mouse_entered():
	$ElevadorInterface0/Botoes.frame = 4
func _on_ButtonAndar4_mouse_exited():
	$ElevadorInterface0/Botoes.frame = 0

func _on_ButtonAndar5_mouse_entered():
	$ElevadorInterface0/Botoes.frame = 5
func _on_ButtonAndar5_mouse_exited():
	$ElevadorInterface0/Botoes.frame = 0
