extends KinematicBody2D

#Declarando variaveis
export var canWalk = true #Variavel públic que pode ser acessada em outros scripts
var speed = 100
var inGround = false
var charactersSpriteArray = [preload("res://Sprites/Personagens/Personagem.png"), 
								preload("res://Sprites/Personagens/PersonagemF.png"), 
								preload("res://Sprites/Personagens/PersonagemP.png"), 
								preload("res://Sprites/Personagens/PersonagemPF.png")]
var sprNumber = 0

onready var characterSprite = get_node("Sprite")
onready var animationTree = $AnimationTree
onready var stateMachine = animationTree.get("parameters/playback")

func _ready():
	#Definindo animação inicial do jogador
	canWalk = false
	stateMachine.travel("idle")

func _process(delta):
	characterSprite.set_texture(charactersSpriteArray[sprNumber])

#Função para movimentar o personagem
func movement(var vel):
	#Definindo para qual direção o personagem deve se mover
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
	
	#Inciando função de movimentação do personagem
	if canWalk:
		movement(velocity)

#Definindo a sprite do personagem de acordo com a escolha do player
func _on_TextureButton_pressed():
	sprNumber = 0
	canWalk = true
	get_node("/root/Level/Seleção de Personagem").queue_free()


func _on_TextureButton2_pressed():
	sprNumber = 1
	canWalk = true
	get_node("/root/Level/Seleção de Personagem").queue_free()


func _on_TextureButton3_pressed():
	sprNumber = 2
	canWalk = true
	get_node("/root/Level/Seleção de Personagem").queue_free()


func _on_TextureButton4_pressed():
	sprNumber = 3
	canWalk = true
	get_node("/root/Level/Seleção de Personagem").queue_free()
