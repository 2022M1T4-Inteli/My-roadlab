# Writtem by Renato Machado
extends Node2D

# Declaring variables
var counter = 0


func _ready():
	# Setting initial parameters
	$PlayerSprite.set_texture(get_node("/root/Level 5/Player").charactersSpriteArray[Global.sprNumber])
	
	$FinalFeedbackScreen/Star1.frame = Global.automationTestTaskPoints[1]
	$FinalFeedbackScreen/Star2.frame = Global.dataTaskPoints[1]
	$FinalFeedbackScreen/Star3.frame = Global.describingTaskPoints[1]
	$FinalFeedbackScreen/Star4.frame = (Global.satelliteTaskPoints[1] + Global.computerTaskPoints[1])/2
	
	$FinalFeedbackScreen/EngenhariaDeSoftware/NivelSatisfacao.text = "Nivel de satisfação: " + str(Global.automationTestTaskPoints[1]) + "/5"
	$FinalFeedbackScreen/SistemaDeInformacao/NivelSatisfacao.text = "Nivel de satisfação: " + str(Global.dataTaskPoints[1]) + "/5"
	$FinalFeedbackScreen/CienciaDaComputacao/NivelSatisfacao.text = "Nivel de satisfação: " + str(Global.describingTaskPoints[1]) + "/5"
	$FinalFeedbackScreen/EngenhariaDaComputacao/NivelSatisfacao.text = "Nivel de satisfação: " + str(int((Global.satelliteTaskPoints[1] + Global.computerTaskPoints[1])/2)) + "/5"
	
	$FinalFeedbackScreen/EngenhariaDeSoftware/ScoreFinal.text = "Score final: " + str(Global.automationTestTaskPoints[0]) + " pontos"
	$FinalFeedbackScreen/SistemaDeInformacao/ScoreFinal.text = "Score final: " + str(Global.dataTaskPoints[0]) + " pontos"
	$FinalFeedbackScreen/CienciaDaComputacao/ScoreFinal.text = "Score final: " + str(Global.describingTaskPoints[0]) + " pontos"
	$FinalFeedbackScreen/EngenhariaDaComputacao/ScoreFinal.text = "Score final: " + str(Global.satelliteTaskPoints[0] + Global.computerTaskPoints[0]) + " pontos"


func _on_PlayAgainButton_pressed():
	get_tree().change_scene_to(load("res://Scenes/Cenários/Menu.tscn"))
