extends Area2D


func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if $SlotIndicator:
		$SlotIndicator.visible = true


func _on_Processador_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if $SlotIndicator:
		$SlotIndicator.visible = false
