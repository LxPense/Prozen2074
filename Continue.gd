extends Control

func _ready():
	pass
	
func _process(delta):
	pass
	
func on_scene_changed():
	pass

func _on_Button_Yes_pressed():
	SceneController.change_current_scene("scene_game")

func _on_Button_No_pressed():
	SceneController.change_current_scene("scene_menu")

