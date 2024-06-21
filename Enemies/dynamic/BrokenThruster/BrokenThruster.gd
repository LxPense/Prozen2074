extends "res://Enemies/Enemy.gd"

export var movement_type = 0
onready var animation_tree : AnimationTree = $AnimationTree


func _init().(25, 700, 1):
	can_shoot = false
	shot_ready = false
	hasActivation = false
	follow = false
	pass

func handle_movement():
	if movement_type == 0:
		move(Vector2(-100, 0), 1,  false, 0)

func _on_VisibilityNotifier2D_screen_entered():
	animation_tree["parameters/conditions/entered_screen"] = true
	animation_tree["parameters/conditions/exited_screen"] = false

func _on_VisibilityNotifier2D_screen_exited():
	animation_tree["parameters/conditions/entered_screen"] = false
	animation_tree["parameters/conditions/exited_screen"] = true

	
