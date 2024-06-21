extends "res://Enemies/Enemy.gd"

onready var animation_tree : AnimationTree = $AnimationTree
onready var animation_player : AnimationPlayer = $Sprite/AnimationPlayer

func _init().(100, 200, 2):
	can_shoot = false
	shot_ready = false
	hasActivation = true
	follow = true
	
	
func _on_Activation_area_body_entered(body):	# If the player enters the activation_area
	if body.is_in_group("player") && hasActivation:
		animation_tree["parameters/conditions/triggered"] = true
		animation_tree["parameters/conditions/untriggered"] = false
		following = true
	
	
func _on_Activation_area_body_exited(body):	# If the player exits the activation_area
	if body.is_in_group("player") && hasActivation:
		animation_tree["parameters/conditions/triggered"] = false
		animation_tree["parameters/conditions/untriggered"] = true
		following = false
