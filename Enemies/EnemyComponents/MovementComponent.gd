extends Node2D
class_name MovementComponent

# Decides whether the component moves according to some wall_movment
var move_with_wall : bool = true

# Is used to activate the steering-behaviour
var can_steer: bool = false

# Instance is used to perform position changes
var instance : KinematicBody2D

# Holds a reference to the player
var player: KinematicBody2D

var movement_speed : Vector2 = Vector2(150, 150)
var movement_vector : Vector2 = Vector2(1, 1)


func _ready():
	pass
	
func activate_steering(should_steer: bool):
	can_steer = should_steer
		
func set_values(_instance: KinematicBody2D, _player: KinematicBody2D):
	instance = _instance
	player = _player
	$SteeringBehaviourComponent.set_steering_behaviour(FollowSteeringBehaviour.new())

func _physics_process(delta):
	move()
	if(can_steer):
		if(move_with_wall):
			instance.move_and_slide(movement_vector * movement_speed + CameraSettings.WALL_CURRENT_MOVEMENT)
		
		else:
			instance.move_and_slide(movement_vector * movement_speed)
			
# If a SteeringBehaviourComponent is used, add the apply_steering()-method into the move()-method 
func move():
		if(instance != null and player != null):
			if can_steer:
				movement_vector = $SteeringBehaviourComponent.apply_steering(instance, PlayerVariables.player)
		else:
			"MovementComponent: instance or player null!"
