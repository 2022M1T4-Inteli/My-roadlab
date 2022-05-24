# Writtem by Renato Machado
extends Area2D

# Declaring variables
var player = false
var floorSelect = false
var _floor = 0

# Variables to adjust the code out the script
export var playerPath = ""
export var chooseFloor = [0, 0, 0, 0, 0]
export var chooseAnim = [0, 0, 0, 0, 0]
export var animDefault = 0

# Publics variables taken on start of game 
onready var animationTree = $AnimationTree
onready var stateMachine = animationTree.get("parameters/playback")


func _ready():
	# Defining initials parameters
	$ElevadorInterface0/Botoes.frame = animDefault
	$ElevadorInterface0.visible = false
	$Button.visible = false


func _process(delta):
	# Oppening floor selection screen and starting elevator animation
	if player && Input.is_action_pressed("ui_E") || player && Global.ePressed:
		stateMachine.travel("Abrindo")
		$ElevadorInterface0.visible = true
		get_node(playerPath).canWalk = false
		floorSelect = true
	# Closing interface of floor selection screen and returning to idle animation
	if floorSelect && Input.is_action_pressed("ui_cancel"):
		$ElevadorInterface0.visible = false
		floorSelect = false
		#Accessing varibles of other node("Player") and changing its values
		get_node(playerPath).canWalk = true
		stateMachine.travel("Fechar")


func _on_Elevador_body_entered(body):
	# Checking if the player is in area
	stateMachine.travel("Abrir")
	player = true
	$Button.visible = true


func _on_Elevador_body_exited(body):
	# Checking if the player left the area
	player = false
	stateMachine.travel("Idle")
	$Button.visible = false


# Closing floor selection screen
func _on_ButtonFechar_pressed():
	$ElevadorInterface0.visible = false
	floorSelect = false
	get_node(playerPath).canWalk = true
	stateMachine.travel("Fechar")


# Checking witch button was pushed and changing level
func _on_ButtonAndar1_pressed():
	get_tree().change_scene_to(load("res://Scenes/Level" + str(chooseFloor[0]) + ".tscn"))

func _on_ButtonAndar2_pressed():
	get_tree().change_scene_to(load("res://Scenes/Level" + str(chooseFloor[1]) + ".tscn"))

func _on_ButtonAndar3_pressed():
	get_tree().change_scene_to(load("res://Scenes/Level" + str(chooseFloor[2]) + ".tscn"))

func _on_ButtonAndar4_pressed():
	get_tree().change_scene_to(load("res://Scenes/Level" + str(chooseFloor[3]) + ".tscn"))
 
func _on_ButtonAndar5_pressed():
	if Global.dataTaskComplete && Global.describingTaskComplete && Global.automationTestTaskComplete && Global.satelliteTaskComplete && Global.computerTaskComplete:
		get_tree().change_scene_to(load("res://Scenes/Level" + str(chooseFloor[4]) + ".tscn"))
	else:
		$Advertise.visible = true


# Checking witch button mouse cursor is on top
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


func _on_Button_pressed():
	$Advertise.visible = false
