extends "res://Enemies/Enemy.gd"

export var movement_type = 0

func _init().(25, 700, 1):
	can_shoot = false
	shot_ready = false
	hasActivation = false
	follow = false
	pass

func handle_movement():
	if movement_type == 0:
		move(Vector2(-100, 0), 1,  false, 0)

