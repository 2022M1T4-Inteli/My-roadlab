# Writtem by Renato Machado
extends KinematicBody2D

# Declaring variables
#Public variable that can be accessed in other scripts
export var canWalk = false

# Movement variables
var speed = 200
var aPressed = false
var dPressed = false

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
	if Global.ePressed:
		print("e")
	
	#Defining witch sprite will be used
	if Global.sprNumber == 3:
		$Sprite.position = spritePosition + Vector2(0, -0.5)
	characterSprite.set_texture(charactersSpriteArray[Global.sprNumber])

	if !canWalk:
		stateMachine.travel("idle")


# Function to movement the player
func movement(var vel):
	# Defining the direction the character will move and defining the scale of the image
	if Input.is_action_pressed("ui_A") || aPressed:
		vel.x -= speed
		stateMachine.travel("walk")
		$Sprite.scale = Vector2(-1, 1)
	elif Input.is_action_pressed("ui_D") || dPressed:
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
	
	# Inicializing movement function
	if canWalk:
		movement(velocity)


# Mobile movement/interact
func _on_ButtonA_button_down():
	aPressed = true


func _on_ButtonA_button_up():
	aPressed = false


func _on_ButtonD_button_down():
	dPressed = true


func _on_ButtonD_button_up():
	dPressed = false


func _on_ButtonE_pressed():
	Global.ePressed = true
	yield(get_tree().create_timer(0.005), "timeout")
	Global.ePressed = false
