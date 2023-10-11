extends Node2D

# This whole scene acts as a base for levels. Only create levels by inheriting this scene.

# A level consist of 4 parallax layers at max
var boss_defeated: bool = false
var level_end_reached: bool = false

# Add functionality to automatically switch a level
var next_level: Node

func _ready():
	pass
		
func _process(_delta):
	if(boss_defeated):
		pass

""" 
Every layer consists out of 2 images (sprites) 2x4 = 8 images (sprites) in total
Not every image has to be set, if so, then it should be null.   
"""


