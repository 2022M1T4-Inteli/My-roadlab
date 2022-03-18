extends KinematicBody2D

# Declarando variaveis
#Variavel publica que pode ser acessada em outros scripts
export var canWalk = false

#Variaveis para movimentação
var speed = 200
var inGround = false

#Variavel para armazenar todas as sprites de personagem
var charactersSpriteArray = [preload("res://Sprites/Personagens/Personagem.png"), 
								preload("res://Sprites/Personagens/PersonagemF.png"), 
								preload("res://Sprites/Personagens/PersonagemP.png"), 
								preload("res://Sprites/Personagens/PersonagemPF.png")]

#Variavel para armazenar qual sprite será selecionada na array
var sprNumber = 0

#Criando variaveis que referenciam a nodes e parametros
onready var characterSprite = get_node("Sprite")
onready var animationTree = $AnimationTree
onready var stateMachine = animationTree.get("parameters/playback")

func _ready():
	#Definindo animação inicial do jogador
	stateMachine.travel("idle")


func _process(delta):
	#Definindo qual sprite deve ser utilizada
	characterSprite.set_texture(charactersSpriteArray[Global.sprNumber])

	if !canWalk:
		stateMachine.travel("idle")


#Função para movimentar o personagem
func movement(var vel):
	# Definindo para qual direção o personagem deve se mover
	# Definindo também para qual direção a sprite está virada
	if Input.is_action_pressed("ui_A"):
		vel.x -= speed
		stateMachine.travel("walk")
		$Sprite.scale = Vector2(-1, 1)
	elif Input.is_action_pressed("ui_D"):
		vel.x += speed
		stateMachine.travel("walk")
		$Sprite.scale = Vector2(1, 1)
	else:
		stateMachine.travel("idle")
	
	#Movendo o personagem
	move_and_slide(vel)


func _physics_process(delta):
	#Declaração de variavel interna
	var velocity = Vector2.ZERO
	
	# Checando se o jogador está ou não no chão
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("Ground"):
			inGround = true
		else:
			inGround = false
	
	# Gerando gravidade caso jogador n esteja no chão
	if inGround == false:
		velocity.y += 200
	else:
		velocity.y = 0
	
	# Inciando função de movimentação do personagem
	if canWalk:
		movement(velocity)
