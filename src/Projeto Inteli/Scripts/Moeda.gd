# Writed by Renato Machado
extends Control


func _process(delta):
	# Uptading coins values
	$Label.text = str(Global.points/10)
