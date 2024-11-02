class_name FollowSteeringBehaviour
extends BaseSteeringBehaviour

func chase_player(enemy_reference: KinematicBody2D, destination_reference: KinematicBody2D):
	# The following is the algorithm which chases the player by its global position
	
	# Calculates the direction vector
	var direction: Vector2 = (destination_reference.global_position - enemy_reference.global_position).normalized() 
	
	# Returns the movement so it can be used inside move_and_slide()
	return direction
	
func steer(enemy_reference: KinematicBody2D, destination_reference: KinematicBody2D):
	
	if(enemy_reference != null and destination_reference != null):
		return chase_player(enemy_reference, destination_reference)
		
	else:
		print("FollowSteeringBehaviour: References are null!!")
