extends ActState

# State to mark this level as completed. In this state the level can be switched.

#This method signals the level-controller (inside the Game-scene) that it can change the level: this only happens when level_end_reached is true 

var level_end_reached: bool = false


func Enter():
	print("Entered Boss")
	pass
	
func Exit():
	pass
	
func Update(_delta: float):	
	pass
	
func Physics_Update(_delta: float):
	pass


func _on_Area2D_body_entered(body):
	if(body.is_in_group("player")):
		level_end_reached = true
		pass
