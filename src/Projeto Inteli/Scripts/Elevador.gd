extends Area2D

# Declaração de variaveis
var player = false
var floorSelect = false
var _floor = 0

# Variaveis para ajustar o código de acordo com a fase
export var playerPath = ""
export var chooseFloor = [0, 0, 0, 0, 0]
export var chooseAnim = [0, 0, 0, 0, 0]
export var animDefault = 0

onready var animationTree = $AnimationTree
onready var stateMachine = animationTree.get("parameters/playback")

func _ready():
	# Definindo o que deve ser visivel inicialmente
	$ElevadorInterface0/Botoes.frame = animDefault
	$ElevadorInterface0.visible = false
	$Button.visible = false

func _process(delta):
	# Abrindo intereface de seleção de andar e inciando animação do elevador abrir
	if player && Input.is_action_pressed("ui_E"):
		stateMachine.travel("Abrindo")
		$ElevadorInterface0.visible = true
		#Acessando variaveis do node "Player", e alterando seus valores
		get_node(playerPath).canWalk = false
		floorSelect = true
	# Fechando inteface de seleção de andar e retornando o elevador a animação padrão
	if floorSelect && Input.is_action_pressed("ui_cancel"):
		#Acessando variaveis do node "Player", e alterando seus valores
		$ElevadorInterface0.visible = false
		floorSelect = false
		get_node(playerPath).canWalk = true
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
	get_node(playerPath).canWalk = true
	stateMachine.travel("Fechar")


# Checando qual botão foi pressionado, para trocar de andar
func _on_ButtonAndar1_pressed():
	get_tree().change_scene_to(load("res://Scenes/Level" + str(chooseFloor[0]) + ".tscn"))

func _on_ButtonAndar2_pressed():
	get_tree().change_scene_to(load("res://Scenes/Level" + str(chooseFloor[1]) + ".tscn"))

func _on_ButtonAndar3_pressed():
	get_tree().change_scene_to(load("res://Scenes/Level" + str(chooseFloor[2]) + ".tscn"))

func _on_ButtonAndar4_pressed():
	get_tree().change_scene_to(load("res://Scenes/Level" + str(chooseFloor[3]) + ".tscn"))

func _on_ButtonAndar5_pressed():
	get_tree().change_scene_to(load("res://Scenes/Level" + str(chooseFloor[4]) + ".tscn"))


# Checando em qual botão o mouse está em cima e alterando as animações de acordo
func _on_ButtonAndar1_mouse_entered():
	$ElevadorInterface0/Botoes.frame = chooseAnim[0] 
func _on_ButtonAndar1_mouse_exited():
	$ElevadorInterface0/Botoes.frame = animDefault

func _on_ButtonAndar2_mouse_entered():
	$ElevadorInterface0/Botoes.frame = chooseAnim[1]
func _on_ButtonAndar2_mouse_exited():
	$ElevadorInterface0/Botoes.frame = animDefault

func _on_ButtonAndar3_mouse_entered():
	$ElevadorInterface0/Botoes.frame = chooseAnim[2]
func _on_ButtonAndar3_mouse_exited():
	$ElevadorInterface0/Botoes.frame = animDefault

func _on_ButtonAndar4_mouse_entered():
	$ElevadorInterface0/Botoes.frame = chooseAnim[3]
func _on_ButtonAndar4_mouse_exited():
	$ElevadorInterface0/Botoes.frame = animDefault

func _on_ButtonAndar5_mouse_entered():
	$ElevadorInterface0/Botoes.frame = chooseAnim[4]
func _on_ButtonAndar5_mouse_exited():
	$ElevadorInterface0/Botoes.frame = animDefault
