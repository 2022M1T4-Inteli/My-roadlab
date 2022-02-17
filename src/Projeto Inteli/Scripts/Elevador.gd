extends Area2D

onready var animationTree = $AnimationTree
onready var stateMachine = animationTree.get("parameters/playback")

func _ready():
	$Button.visible = false


func _on_Elevador_body_entered(body):
	stateMachine.travel("Abrir")
	$Button.visible = true


func _on_Elevador_body_exited(body):
	stateMachine.travel("Idle")
	$Button.visible = false
