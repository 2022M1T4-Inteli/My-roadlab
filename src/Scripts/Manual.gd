extends Control

func _ready():
	# Animating texts.
	animateText($SectionTitle, 1)
	animateText($SectionDescription, 1)
	animateText($E_key_description, 1)
	animateText($D_key_description, 1)
	animateText($A_key_description, 1)
	animateText($NPC_description, 1)

func _on_CloseBtn_pressed():
	# Closing window when close button was clicked.
	Global.introduction = true
	get_node("/root/Level/IntroductionToEnergySystem").visible = true
	queue_free()

func animateText(object : Object, time : int):
	# Animating window texts with tween class.
	object.percent_visible = 0
	$Tween.interpolate_property(object, "percent_visible", 0, 1, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
