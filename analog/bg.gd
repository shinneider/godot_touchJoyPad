extends Node2D


var height = 128 #target height
var width = 128 #target width



func _ready():
	get_node("bg").scale = Vector2(2,2)
