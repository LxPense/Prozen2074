extends Control

var current_scene = null

func _on_Button_start_pressed():
	SceneController.change_current_scene("scene_game")
	PlayerVariables.screen_exited_expected = false
	
func _on_Button_quit_pressed():
	get_tree().quit()
