extends Control

var current_scene = null

func _on_Button_start_pressed():
	current_scene = get_tree().change_scene("res://Game.tscn")

func _on_Button_quit_pressed():
	get_tree().quit()
