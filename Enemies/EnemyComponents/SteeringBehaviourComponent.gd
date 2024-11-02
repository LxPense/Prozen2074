extends Node2D
class_name SteeringBehaviourComponent

# IMPORTANT: Has to be added to a movementcomponent, as the movementcomponent handles the movement
# The steeringbehaviour directly changes the movement, as such the movementcomponent is necessary

# Is used to add simple steering behaviours to an enemy
# Implemented by using the strategy-pattern to switch between steering-behaviours

var current_steering_behaviour : BaseSteeringBehaviour
var source: KinematicBody2D
var destination: KinematicBody2D

func _ready():
	pass


# Sets the desired steering-behaviour
func set_steering_behaviour(specificSteeringBehaviour: BaseSteeringBehaviour):
	current_steering_behaviour = specificSteeringBehaviour
	
# This method is supposed to be used inside the physics_process-method of KinematicBody2D
func apply_steering(source: KinematicBody2D, destination: KinematicBody2D):
	if(current_steering_behaviour != null):
		return current_steering_behaviour.steer(source, destination)
	else:
		print("Steering behaviour is null!")
