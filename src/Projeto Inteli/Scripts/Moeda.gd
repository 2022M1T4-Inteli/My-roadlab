extends Control


func _process(delta):
	# Atualizando o valor das moedas no label
	$Label.text = str(Global.pontos/10)
