extends Control

# Controlling the task step.
var stepController = 1;
var quantityOfSteps = 5;
var isScoreCalculated = false;
var isTimeCountRunning = false;

# Counting the task correct and incorrent answers.
var correctAnswersCounter = 0;
var incorrectAnswersCounter = 0;

# Defining the task first step texts.
var firstStep = {
	expectedInputText = "Receber número x\nReceber número y",
	expectedOutputText = "Retornar x+y",
	inputValues = "15, 10",
	outputValue = "25",
	isCorrect = true,
}

# Defining the task second step texts.
var secondStep = {
	expectedInputText = "Receber número x\nReceber número y\nReceber número z",
	expectedOutputText = "Retornar x^2 + y^2 + z^2",
	inputValues = "1, 2, 3",
	outputValue = "15",
	isCorrect = false,
}

var thirdStep = {
	expectedInputText = "Receber número a\nReceber número b\nReceber número c",
	expectedOutputText = "Retornar raíz de ax^2 + bx + c",
	inputValues = "4, -4, 1",
	outputValue = "1/8",
	isCorrect = false,
}

var fourthStep = {
	expectedInputText = "Receber texto x",
	expectedOutputText = "Retornar texto x escrito de forma inversa",
	inputValues = "arara",
	outputValue = "arara",
	isCorrect = true,
}

var fifthStep = {
	expectedInputText = "Receber função f",
	expectedOutputText = "Retornar a derivada de f em relação a variável x",
	inputValues = "f(x) = 3 . x^3",
	outputValue = "f'(x) = 9 . x^2",
	isCorrect = true,
}

func _ready():
	# Disabling all task buttons.
	$CloseTaskButton.disabled = true;
	$CorrectOutputButton.disabled = true;
	$IncorrectOutputButton.disabled = true;
	
	
func _process(delta):
	
	if(stepController == quantityOfSteps + 1 && !isScoreCalculated):
		
		isScoreCalculated = true;
		
		if(float(correctAnswersCounter) / float(quantityOfSteps) < 0.75):
			get_node("/root/Level 4/TasksSpawn/Root/TryAgainPopup").visible = true;
		else:
			get_node("/root/Level 4/TasksSpawn/Root/TaskFinishedPopup").visible = true;
			if !Global.automationTestTaskComplete:
				Global.automationTestTaskPoints[0] += 100
				Global.energy -= 1
				get_node("/root/Level 4/Player").canWalk = true
				get_node("/root/Level 4/Cenário 5").taskOcorring = false
				Global.automationTestTaskComplete = true
		
	else:
		# Handling texts according to the task current step.
		match stepController:
			1:
				textsHandler(firstStep)
			2:
				textsHandler(secondStep)
			3:
				textsHandler(thirdStep)
			4:
				textsHandler(fourthStep)
			5:
				textsHandler(fifthStep)
	
func textsHandler(step):
	
	# Setting up the task texts on the screen.
	$Terminal/Inputs.text = step.expectedInputText;
	$Terminal/DesiredOutput.text = step.expectedOutputText;
	$InputsValues.text = step.inputValues;
	$DesiredOutputValue.text  = str(step.outputValue);
	
func _on_IncorrectOutputButton_pressed():
	
	# Sending the user's answer to task step validator.
	stepValidator(false, stepController);
	

func _on_CorrectOutputButton_pressed():
	
	# Sending the user's answer to task step validator.
	stepValidator(true, stepController);

func stepValidator(isCorrect, step):
	
	# Handling the calc according to the task current step.
	match step:
		1:
			if(firstStep.isCorrect == isCorrect):
				stepController += 1;
				correctAnswersCounter += 1;
				$TaskStatusFrameStep1.frame = 1;
			else:
				stepController += 1
				incorrectAnswersCounter += 1;
				$TaskStatusFrameStep1.frame = 2
		2:
			if(secondStep.isCorrect == isCorrect):
				stepController += 1;
				correctAnswersCounter += 1;
				$TaskStatusFrameStep2.frame = 1;
			else:
				stepController += 1;
				incorrectAnswersCounter += 1;
				$TaskStatusFrameStep2.frame = 2;
		3:
			if(thirdStep.isCorrect == isCorrect):
				stepController += 1;
				correctAnswersCounter += 1;
				$TaskStatusFrameStep3.frame = 1;
			else:
				stepController += 1;
				incorrectAnswersCounter += 1;
				$TaskStatusFrameStep3.frame = 2;
		4:
			if(fourthStep.isCorrect == isCorrect):
				stepController += 1;
				correctAnswersCounter += 1;
				$TaskStatusFrameStep4.frame = 1;
			else:
				stepController += 1;
				incorrectAnswersCounter += 1;
				$TaskStatusFrameStep4.frame = 2;
		5:
			if(fifthStep.isCorrect == isCorrect):
				stepController += 1;
				correctAnswersCounter += 1;
				$TaskStatusFrameStep5.frame = 1;
			else:
				stepController += 1;
				incorrectAnswersCounter += 1;
				$TaskStatusFrameStep5.frame = 2;
			

# Closing scene when the close button was pressed.
func _on_CloseButton_pressed():
	get_node("/root/Level 4/TasksSpawn/Root/Star").visible = true
	get_node("/root/Level 4/TasksSpawn/Root/TaskFinishedPopup").visible = false
	

# Restarting the task when the try again button was pressed.
func _on_TryAgainButton_pressed():
	stepController = 1;
	isScoreCalculated = false;
	correctAnswersCounter = 0;
	incorrectAnswersCounter = 0;
	$TaskStatusFrameStep1.frame = 0;
	$TaskStatusFrameStep2.frame = 0;
	$TaskStatusFrameStep3.frame = 0;
	$TaskStatusFrameStep4.frame = 0;
	$TaskStatusFrameStep5.frame = 0;
	$TimeBar.rect_size.x = 376;
	startTaskTimer();
	get_node("/root/Level 4/TasksSpawn/Root/TryAgainPopup").visible = false;
	
func startTaskTimer():
	
	# Setting up the time count as running.
	isTimeCountRunning = true;
	
	# Reducing time bar...
	startReduceTimeBar();
	
	# Waiting ninety seconds...
	yield(get_tree().create_timer(90), "timeout")
	
	# Setting up the time count as not running.
	isTimeCountRunning = false;
	
	if(!isScoreCalculated):
		# Showing the task try again popup.
		get_node("/root/Level 4/TasksSpawn/Root/Task/TryAgainPopup").visible = true;


func startReduceTimeBar():
	
	while(isTimeCountRunning && !isScoreCalculated):
		yield(get_tree().create_timer(0.01), "timeout");
		$TimeBar.rect_size.x -= 0.07; 


func _on_CloseTaskButton_pressed():
	get_node("/root/Level 4/Player").canWalk = true
	get_node("/root/Level 4/Cenário 5").taskOcorring = false
	get_node("/root/Level 4/TasksSpawn/Root").queue_free()
