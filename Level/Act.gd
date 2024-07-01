extends ActState

signal act1_finished

# This function is called when the act enters the state_machine 
func enter():
	CameraSettings.reset_camera()
	PlayerVariables.set_player_position(get_node("other/PlayerPointer").position)

func _on_ActEnd_body_entered(body):
	if(body.is_in_group("player")):
		emit_signal("act1_finished")
