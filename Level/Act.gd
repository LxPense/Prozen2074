extends ActState

signal act1_finished


func _ready():
	connect("reload_scene_with_player", self, "reload")

# This function is called when the act enters the state_machine 

func enter():
	CameraSettings.reset_camera()
	PlayerVariables.set_player_position(get_node("other/PlayerPointer").position)

func reload():
	get_tree().reload_current_scene()	

func _on_ActEnd_body_entered(body):
	if(body.is_in_group("player")):
		emit_signal("act1_finished")
