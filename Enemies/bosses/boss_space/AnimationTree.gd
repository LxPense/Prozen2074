extends AnimationTree

func set_condition(condition_name, value):
	# The condition shots_fired is true when the boss has fired all projectiles from its weapon
	# It is used so that the SpaceBoss_shoot-animation doesn't finish immediately, but rather in x shots
	set("parameters/conditions/" + condition_name, value)
