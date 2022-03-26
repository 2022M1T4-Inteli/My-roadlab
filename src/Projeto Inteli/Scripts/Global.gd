# A Global node that the variables are kept even after level change
extends Node

# Declaring variables
var sprNumber = 0
var pontos = 0
var introduction = false

var totalComputer = 0

var taskDescribing = preload("res://Scenes/Tasks/DescribingTask.tscn")
var taskData = preload("res://Scenes/Tasks/DataTask.tscn")
var taskAutomationTest = preload("res://Scenes/Tasks/TestAutomationTask.tscn")

var satelliteTaskComplete = false
var describingTaskComplete = false
var computerTaskComplete = false
var dataTaskComplete = false
var automationTestTaskComplete = false

var objCatched = false
