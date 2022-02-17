extends Area2D

#Declaração de variaveis
onready var animationTree = $AnimationTree
onready var stateMachine = animationTree.get("parameters/playback")

func _ready():
	#Definindo o que deve ser visivel inicialmente
	$Button.visible = false


func _on_Elevador_body_entered(body):
	#checando se o jogador entrou na área e alterando animação
	stateMachine.travel("Abrir")
	$Button.visible = true


func _on_Elevador_body_exited(body):
	#checando se o jogador saiu da área e alterando animação
	stateMachine.travel("Idle")
	$Button.visible = false
