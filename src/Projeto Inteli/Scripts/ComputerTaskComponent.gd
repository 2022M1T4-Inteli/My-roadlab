extends Area2D

# Declaring varibles
var mouse = false
var move = true
var onSocket = false
export var socketName = ""
export var socketPath = ""

onready var defaultPosition = self.position


func _ready():
	# Defining initial parameters
	input_pickable = true


func _physics_process(delta):
	# Criando movimentação dos objetos por meio do mouse
	if onSocket && !Input.is_mouse_button_pressed(1):
		move = false
		Global.totalComputer += 1
	if move:
		if mouse && Input.is_mouse_button_pressed(1):
			self.position = get_global_mouse_position()
		else:
			self.position = defaultPosition
			pass
	else:
		get_node(socketPath + "/InSlot").visible = true
		$Sprite.visible = false
		Global.objCatched = false
		get_node(socketPath + "/SlotIndicator").queue_free()
		self.queue_free()


# Checando se o mouse entrou na área
func _on_KinematicBody2D_mouse_entered():
	if !Global.objCatched && move:
		$Sprite.frame = 1
		mouse = true
		Global.objCatched = true


# Checando se o mouse saiu da área
func _on_KinematicBody2D_mouse_exited():
	if !Input.is_mouse_button_pressed(1) && move:
		$Sprite.frame = 0
		mouse = false
		Global.objCatched = false


# Checando se o objeto entrou no local alvo
func _on_KinematicBody2D_body_entered(body):
	if body.is_in_group(socketName):
		onSocket = true


# Checando se o objeto saiu do local alvo
func _on_KinematicBody2D_body_exited(body):
	if body.is_in_group(socketName):
		onSocket = false
