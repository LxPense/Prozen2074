extends ActState

signal act1_transition_finished

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

