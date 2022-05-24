# Writtem by Renato Machado
# A Global node that the variables are kept even after level change
extends Node

# Declaring variables
var sprNumber = 0
var satelliteTaskPoints = [0, 0]
var describingTaskPoints = [0, 0]
var computerTaskPoints = [0, 0]
var dataTaskPoints = [0, 0]
var automationTestTaskPoints = [0, 0]
var points = 0
var introduction = false

var moneySpend = 0

var totalComputer = 0

var taskDescribing = preload("res://Scenes/Tasks/DescribingTask.tscn")
var taskData = preload("res://Scenes/Tasks/DataTask.tscn")
var taskAutomationTest = preload("res://Scenes/Tasks/TestAutomationTask.tscn")

var satelliteTaskComplete = false
var describingTaskComplete = false
var computerTaskComplete = false
var dataTaskComplete = false
var automationTestTaskComplete = false

var ePressed = false

var objCatched = false

var energy = 3

func _process(delta):
	points = (satelliteTaskPoints[0] + describingTaskPoints[0] + computerTaskPoints[0] + dataTaskPoints[0] + automationTestTaskPoints[0]) - moneySpend
