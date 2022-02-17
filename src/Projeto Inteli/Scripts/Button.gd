extends Node2D

#Declaração de variaveis
onready var animationTree = $AnimationTree
onready var stateMachine = animationTree.get("parameters/playback")

func _ready():
	#Definindo qual animação rodar
	stateMachine.travel("Botao")
