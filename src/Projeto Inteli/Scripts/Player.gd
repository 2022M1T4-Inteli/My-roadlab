# Writed by Renato Machado
extends KinematicBody2D

# Declaring variables
#Public variable that can be accessed in other scripts
export var canWalk = false

# Movement variables
var speed = 200
var inGround = false

#Variable to storege sprites archives
var charactersSpriteArray = [preload("res://Sprites/Personagens/Personagem.png"), 
								preload("res://Sprites/Personagens/PersonagemF.png"), 
								preload("res://Sprites/Personagens/PersonagemP.png"), 
								preload("res://Sprites/Personagens/PersonagemPF.png")]

#Variable to storege sprite will be selected
var sprNumber = 0

# Creating varaibles that references parameters
onready var characterSprite = get_node("Sprite")
onready var animationTree = $AnimationTree
onready var stateMachine = animationTree.get("parameters/playback")
onready var spritePosition = $Sprite.position


func _ready():
	#Setting first animation
	stateMachine.travel("idle")


func _process(delta):
	#Defining witch sprite will be used
	if Global.sprNumber == 3:
		$Sprite.position = spritePosition + Vector2(0, -0.5)
	characterSprite.set_texture(charactersSpriteArray[Global.sprNumber])

	if !canWalk:
		stateMachine.travel("idle")


# Function to movement the player
func movement(var vel):
	# Defining the direction the character will move and defining the scale of the image
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
	
	#Moving character
	move_and_slide(vel)


func _physics_process(delta):
	#Declaring local variable
	var velocity = Vector2.ZERO
	
	# Checking if the player is in the ground
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("Ground"):
			inGround = true
		else:
			inGround = false
	
	# Creating gravity to keep the player in the ground
	if inGround == false:
		velocity.y += 200
	else:
		velocity.y = 0
	
	# Inicializing movement function
	if canWalk:
		movement(velocity)
