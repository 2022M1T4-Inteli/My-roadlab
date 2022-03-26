extends Control


func _process(delta):
	# Uptading coins values
	$Label.text = str(Global.pontos/10)
