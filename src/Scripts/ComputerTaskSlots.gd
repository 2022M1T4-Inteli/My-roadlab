# Writtem by Renato Machado
extends Area2D

# Declaring variables
var activate = false


func _ready():
	# Activating collision
	yield(get_tree().create_timer(1), "timeout");
	activate = true


# Checking if any component entered the area
func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if $SlotIndicator && activate:
		$SlotIndicator.visible = true


func _on_Processador_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if $SlotIndicator && activate:
		$SlotIndicator.visible = false
