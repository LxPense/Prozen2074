extends Node2D
class_name BaseSteeringBehaviour

# The steering-behaviours are implemented with the strategy-pattern
	
# This is the main method to handle the steering, each SteeringBehaviour has to implement this method seperately
func steer(enemy_reference: KinematicBody2D, destination_reference: KinematicBody2D):
	pass
