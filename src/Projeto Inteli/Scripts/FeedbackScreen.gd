# Writed by Renato Machado
extends Node2D


func _ready():
	# Setting initial parameters
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
