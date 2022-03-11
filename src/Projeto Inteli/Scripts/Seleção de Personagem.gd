extends Control

# Declaração de variaveis
var op1 = false
var op2 = false
var op3 = false
var op4 = false


func _ready():
	pass

# Fazendo transição entre as animações
func _process(delta):
	if op1:
		$Sprite.frame = 1
	elif op2:
		$Sprite.frame = 2
	elif op3:
		$Sprite.frame = 3
	elif op4:
		$Sprite.frame = 4
	else:
		$Sprite.frame = 0


# Definindo qual a sprite do personagem que foi selecionada
func _on_Op1_pressed():
	get_node("/root/Level/Player").sprNumber = 0
	get_node("/root/Level/Player").canWalk = true
	get_node("/root/Level/Seleção de Personagem").queue_free()

func _on_Op2_pressed():
	get_node("/root/Level/Player").sprNumber = 1
	get_node("/root/Level/Player").canWalk = true
	get_node("/root/Level/Seleção de Personagem").queue_free()

func _on_Op3_pressed():
	get_node("/root/Level/Player").sprNumber = 2
	get_node("/root/Level/Player").canWalk = true
	get_node("/root/Level/Seleção de Personagem").queue_free()

func _on_Op4_pressed():
	get_node("/root/Level/Player").sprNumber = 3
	get_node("/root/Level/Player").canWalk = true
	get_node("/root/Level/Seleção de Personagem").queue_free()



# Checando se o mouse está em algum botão para alterar a animação da tela de seleção
func _on_Op1_mouse_entered():
	op1 = true
func _on_Op1_mouse_exited():
	op1 = false

func _on_Op2_mouse_entered():
	op2 = true
func _on_Op2_mouse_exited():
	op2 = false

func _on_Op3_mouse_entered():
	op3 = true
func _on_Op3_mouse_exited():
	op3 = false

func _on_Op4_mouse_entered():
	op4 = true
func _on_Op4_mouse_exited():
	op4 = false
