extends Node2D

# This whole scene acts as a base for levels. Only create levels by inheriting this scene.

# A level consist of 4 parallax layers at max
var boss_defeated: bool = false
var level_end_reached: bool = false

#This signal is used to notify the level-handler that it can change the level
signal can_change_level

func _ready():
	connect("my_signal", self, "signal_handler")
	pass
		
func _process(_delta):
	if(level_end_reached):
		signal_level_change()

#This method signals the level-controller (inside the Game-scene) that it can change the level: this only happens when level_end_reached is true 
func signal_level_change():
	emit_signal("can_change_level")
	

""" 
Every layer consists out of 2 images (sprites) 2x4 = 8 images (sprites) in total
Not every image has to be set, if so, then it should be null.   
"""

# Called, when the player reaches the end of the level
func _on_Area2D_body_entered(body):
	if(body.is_in_group("player")):
		level_end_reached = true
		pass
