extends KinematicBody2D

#Declarando variaveis
var speed = 100
var inGround = false

onready var animationTree = $AnimationTree
onready var stateMachine = animationTree.get("parameters/playback")

func _ready():
	#Definindo animação inicial do jogador
	stateMachine.travel("idle")

func _physics_process(delta):
	#Declaração de variavel interna
	var velocity = Vector2.ZERO
	 
	#Checando se o jogador está ou não no chão
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("Ground"):
			inGround = true
		else:
			inGround = false
	
	#Gerando gravidade caso jogador n esteja no chão
	if inGround == false:
		velocity.y += 200
	else:
		velocity.y = 0
	
	#Definindo para qual direção o personagem deve se mover
	if Input.is_action_pressed("ui_A"):
		velocity.x -= speed
		stateMachine.travel("walk")
		$Sprite.scale = Vector2(-1, 1)
	elif Input.is_action_pressed("ui_D"):
		velocity.x += speed
		stateMachine.travel("walk")
		$Sprite.scale = Vector2(1, 1)
	else:
		stateMachine.travel("idle")
	
	#Movendo o personagem
	move_and_slide(velocity)
