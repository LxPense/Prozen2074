extends Enemy
class_name Enemy_Drone

export var movement_type = 0

#50 = health, 200 = speed, 1 = health
func _init().(50, 300, 2):
	pass
	
func shoot():
	pass
	



func _on_Activation_area_body_entered(body):
	if(body.is_in_group("player")):
		print("yes")


func _on_VisibilityNotifier2D_screen_entered():
	print("Entered")


func _on_Activation_area_area_entered(area):
	if(area.is_in_group("player")):
		print("PLAY")
