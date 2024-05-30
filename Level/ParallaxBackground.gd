extends ActState

signal act2_transition_finished

func handle_input(_event: InputEvent):
	pass

func enter():
	CameraSettings.reset_camera()
	CameraSettings.change_camera_move(false)
	PlayerVariables.change_player_active(false)
	get_node("AnimationPlayer").play("animation_act1_transition")
	pass
	
func exit():
	CameraSettings.change_camera_move(true)
	PlayerVariables.change_player_active(true)
	
func update(_delta: float):
	pass
	
func physics_update(_delta: float):
	pass

# After the animation inside the AnimationPlayer has finished,
# a signal for changing the current act is emitted

func _on_AnimationPlayer_animation_finished(act1_transition):
	emit_signal("act1_transition_finished")

# Note: The x-offset of each ParallaxLayer is set to -500, so each layer starts a bit left to
# the beginning of the background (this is needed because the backgrounds are drawn a bit to the right by the ParallaxLayers per default 

# Note: Each image gets repeated by changing the region of each sprite seperately.
# There is another solution to this by using the mirroring-attribute of each ParallaxLayer.
# This achieves the same effect, but somehow it doesn't work because the z-index isn't considered
# which makes the sprites overlap
