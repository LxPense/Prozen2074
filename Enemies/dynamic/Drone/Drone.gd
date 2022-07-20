extends "res://Enemies/Enemy.gd"

export var movement_type = 0

#50 = health, 200 = speed, 1 = health
func _init().(50, 300, 2):
	can_shoot = true
	
func handle_movement():
	if movement_type == 0:
		move(Vector2(0, 500), 1, false, 0)
		

