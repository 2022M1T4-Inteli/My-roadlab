extends Node2D

# Declaração de variavies
var playerDescribing = false
var taskDescribing = preload("res://Scenes/Tasks/DescribingTask.tscn")
var taskOcorring = false

func _ready():
	pass


func _process(delta):
	# Iniciando a task após a interação por meio do botão "E" e a presença do jogador na área
	if playerDescribing && Input.is_action_just_pressed("ui_E") && !taskOcorring && !Global.describingTaskComplete:
		var task = taskDescribing.instance()
		get_node("/root/Level 1/TasksSpawn").add_child(task)
		$DescribingTask/Button.visible = false
		$DescribingTask/Sprite.frame = 0
		get_node("/root/Level 1/Player").canWalk = false
		taskOcorring = true
	if !taskOcorring && playerDescribing && !Global.describingTaskComplete:
		$DescribingTask/Sprite.frame = 1
		$DescribingTask/Button.visible = true


# Checando se o jogador está na área
func _on_DescribingTask_body_exited(body):
	playerDescribing = false
	$DescribingTask/Sprite.frame = 0
	$DescribingTask/Button.visible = false

# Checando se o jogador está na árae
func _on_DescribingTask_body_entered(body):
	if !Global.describingTaskComplete:
		playerDescribing = true
		$DescribingTask/Sprite.frame = 1
		$DescribingTask/Button.visible = true
