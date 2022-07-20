extends "res://Enemies/Enemy.gd"

func _init().(100, 200, 2):
	can_shoot = false
	shot_ready = false
	hasActivation = true
	follow = true
	pass
	
func _on_Activation_area_body_entered(body):	# If the player enters the activation_area
	if body.is_in_group("player") && hasActivation:
		$Sprite/AnimationPlayer.play("triggered")
		following = true
	
	
func _on_Activation_area_body_exited(body):	# If the player enters the activation_area
	pass
