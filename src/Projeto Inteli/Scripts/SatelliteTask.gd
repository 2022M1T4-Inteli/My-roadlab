extends Node2D


# Instancing all required variables of the current task.
var isFirstSatelliteConnected = false
var isSecondSatelliteConnected = false
var isThirdSatelliteConnected = false
var isFourthSatelliteConnected = false
var didThePlayerWin = false


func _ready():
	# Animating first terminal text.
	animateText($Terminal, 3)


func animateText(object : Object, time : int):
	# Animating task texts with tween class.
	object.percent_visible = 0
	$Tween.interpolate_property(object, "percent_visible", 0, 1, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _process(delta):
	# Freeing the transmission button when all satellites was connected.
	if (isFirstSatelliteConnected && isSecondSatelliteConnected && isThirdSatelliteConnected && isFourthSatelliteConnected):
		$Waiting_transmission_message.visible = true
		$Waiting_transmission_message.text = "Aguardando transmissão...\nPressione o satélite para iniciar a transmissão."
		$Control/Start_transmission_button.disabled = false
		$Control/Start_transmission_button.visible = true
	else:
		$Waiting_transmission_message.visible = false
		$Control/Start_transmission_button.disabled = true


func _on_Next_button_pressed():
	# Transitioning the frame when next button was pressed.
	$Background.frame = 1
	$Terminal.visible = false
	$Description.visible = false
	$Slider1.visible = true
	$Slider2.visible = true
	$Slider3.visible = true
	$Slider4.visible = true
	$Satellite1.visible = true
	$Satellite2.visible = true
	$Satellite3.visible = true
	$Satellite4.visible = true
	$Control/Next_button.disabled = true
	$Waiting_adjustments_message.visible = true


func _on_Slider1_value_changed(value):
	
	satelliteControl($Satellite1, $Satellite1_status_message, $Slider1, 120, 1, 40, 180)

func _on_Slider2_value_changed(value):
	
	satelliteControl($Satellite2, $Satellite2_status_message, $Slider2, 75, 2, 50, 200)


func _on_Slider3_value_changed(value):
	
	satelliteControl($Satellite3, $Satellite3_status_message, $Slider3, 75, 3, 50, 200)


func _on_Slider4_value_changed(value):
	
	satelliteControl($Satellite4, $Satellite4_status_message, $Slider4, 90, 4, 65, 200)
	
	
func satelliteControl(SatelliteObj : Object, SatelliteStatusMessageObj : Object, SliderObj : Object, SumSteps : int, ChannelNumber : int, MinPos : int, MaxPos : int):
	
	# Setting the target satellite position equals to Slider Object value + SumSteps.
	SatelliteObj.position.y = SliderObj.value + SumSteps
	
	# Checking if the target satellite is aligned as the task requires.
	if(SatelliteObj.position.y >= 115 && SatelliteObj.position.y <= 135):
		
		# Matching the channel number with the corresponding satellite and setting up it to true.
		setSatelliteConnectionStatus(ChannelNumber, true)
			
		# Printing the success message on the screen.
		SatelliteStatusMessageObj.text = "Canal " + str(ChannelNumber) + " sintonizado com sucesso."
		SatelliteStatusMessageObj.visible = true
		
		# Animating the success message.
		animateText(SatelliteStatusMessageObj, 1)
		
		# Setting up the message text color to green.
		SatelliteStatusMessageObj.add_color_override("default_color", Color(0,1,0,1))
	else:
		
		# Matching the channel number with the corresponding satellite and setting up it to false.
		setSatelliteConnectionStatus(ChannelNumber, false)
		
		# Printing the error message on the screen.
		SatelliteStatusMessageObj.text = "Canal " + str(ChannelNumber) + " não sintonizado."
		SatelliteStatusMessageObj.visible = true
		
		# Antimating the error message.
		animateText(SatelliteStatusMessageObj, 1)
		
		# Setting up the message text color to red.
		SatelliteStatusMessageObj.add_color_override("default_color", Color(1,0,0,1))
	
	# Setting up the satellite position minimum and maximum values.
	if(SatelliteObj.position.y < MinPos):
		SatelliteObj.position.y = MinPos
	elif(SatelliteObj.position.y > MaxPos):
		SatelliteObj.position.y = MaxPos


func setSatelliteConnectionStatus(ChannelNumber : int, Status : bool):
	# Matching the channel number and bool values with global script variables.
	match (ChannelNumber):
		1:
			isFirstSatelliteConnected = Status
		2:
			isSecondSatelliteConnected = Status
		3:
			isThirdSatelliteConnected = Status
		4:
			isFourthSatelliteConnected = Status


func _on_Background_frame_changed():
	# Animating text when the frame was changed.
	if($Background.frame == 1):
		animateText($Waiting_adjustments_message, 2)


func _on_Start_transmission_button_pressed():
	# Initializing the transmission dynamics since player didn't win yet.
	if(!didThePlayerWin):
		
		# Setting up the final terminal message visible and animating it.
		$Final_message.visible = true
		animateText($Final_message, 10)
		
		# Waiting ten seconds...
		yield(get_tree().create_timer(10), "timeout")
		
		# Showing score and close task window.
		showScoreAndCloseTaskWindow()
	
	
func showScoreAndCloseTaskWindow():
	# Adding points for the player
	if !Global.satelliteTaskComplete:
		Global.satelliteTaskPoints[0] += 50
		Global.energy -= 1
	Global.satelliteTaskComplete = true
	
	
	# Setting up the game status as completed.
	didThePlayerWin = true
	
	# Enabling and disabling some nodes.
	$Earned_score.visible = true
	$Task_finished.visible = true
	$Control/Close_button.visible = false
	$Control/Close_button.disabled = true
	$Task_finished_close_button.visible = true
	$Task_finished_close_button.disabled = false
	$Score_congratulations_message.visible = true
	$Control/Start_transmission_button.visible = false
	$Control/Start_transmission_button.disabled = true
	
func _on_Close_button_pressed():
	_close()
	
func _on_Task_finished_close_button_pressed():
	$Star.visible = true
	$Earned_score.visible = false
	$Task_finished.visible = false
	$Task_finished_close_button.visible = false
	$Task_finished_close_button.disabled = true
	$Score_congratulations_message.visible = false


func _close():
	# Closing the task when close button was pressed.
	get_node("/root/Level 2/Cenário 3")._restart()
	queue_free()
