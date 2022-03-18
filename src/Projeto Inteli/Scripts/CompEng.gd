extends Node2D

# Declaração de variavel
var playerSatellite = false
var taskSatellite = preload("res://Scenes/Tasks/SatelliteTask.tscn")
var taskOcorring = false

func _ready():
	# Definindo os parametros inicias
	$SatelliteTaskArea/Button.visible = false
	$SatelliteTaskArea/Sprite.frame = 0


func _process(delta):
	# Iniciando a task após a interação por meio do botão "E" e a presença do jogador na área
	if playerSatellite && Input.is_action_just_pressed("ui_E") && !taskOcorring && !Global.satelliteTaskComplete:
		var task = taskSatellite.instance()
		get_node("/root/Level 2/TasksSpawn").add_child(task)
		$SatelliteTaskArea/Button.visible = false
		$SatelliteTaskArea/Sprite.frame = 0
		get_node("/root/Level 2/Player").canWalk = false
		taskOcorring = true


# Função para reiniciar os parametros iniciais da task
func _restart():
	get_node("/root/Level 2/Player").canWalk = true
	$SatelliteTaskArea/Button.visible = true
	$SatelliteTaskArea/Sprite.frame = 1
	taskOcorring = false


# Checando se o jogador está na área
func _on_SatelliteTaskArea_body_entered(body):
	if !Global.satelliteTaskComplete:
		$SatelliteTaskArea/Button.visible = true
		$SatelliteTaskArea/Sprite.frame = 1
		playerSatellite = true


# Checando se o jogador saiu da área
func _on_SatelliteTaskArea_body_exited(body):
	$SatelliteTaskArea/Button.visible = false
	$SatelliteTaskArea/Sprite.frame = 0
	playerSatellite = false
