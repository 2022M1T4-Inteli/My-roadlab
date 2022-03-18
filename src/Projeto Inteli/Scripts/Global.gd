# Node Global o qual as variaveis se mantém mesmo após a mudança de fase
extends Node

# Declaração de variaveis
var sprNumber = 0
var pontos = 0
var introduction = false

var totalComputer = 0

var taskDescribing = preload("res://Scenes/Tasks/DescribingTask.tscn")

var satelliteTaskComplete = false
var describingTaskComplete = false

var objCatched = false
