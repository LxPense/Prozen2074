extends KinematicBody2D

var player = null
var inside_camera = false	#determines whether enemy is inside camera or not, see check_inside_camera()
var firstActivation = false #holds boolean if the activation is the first one or not, used in combination with AnimationPlayer
var starting_pos
var movement

onready var states = {
	
}

var health = 1
var score = 0
var speed = 200

const BULLET = preload("res://Bullets/Bullet.tscn")
var bullet_speed = 200
var can_shoot = false #determines whether the enemy can shoot, false by default, interacts with can_shoot_at (if unnecessary movement is finished, the enemy is able to shoot)
var shot_ready = true #used for stopping and starting the shooting in combination with the shotTimer

var canMove = false
var hasActivation = false	#decides whether the enemy has an area where it becomes active when player enters it, set to false by default
var follow = false	#enemy follows player if true, set to false by default
var following = false

var origin_position = position
var determine_origin_position = true
var desired_position = null
var current_movement = 1
const OUTSIDE_BUFFER = 100 # decides how far an enemy can be outside the camera to still be recognized  

var movement_to_player = 0 #Get's calculated by follow_player and shows the vector that needs to be applied to reach to the player

func _init(_score = 0, _speed = 150, _health = 1):
	score = _score
	speed = _speed
	health = _health

func _ready():
	starting_pos = position
	$Sprite/AnimationPlayer.play("spawn")
	pass

#If some unnecessary movement (like flying into the screen) is finished, the enemy can shoot normally, max_movement specifies until which part of the movement it is considered unnecessary
func can_shoot_at(max_movement):
	if current_movement == max_movement:
		can_shoot = true
	
func _physics_process(_delta) -> void:
	#states._physics_process(_delta)
	
	check_inside_camera()
	if(inside_camera):
		
		$CurrentPosition.position = position
		canMove = true
		
		if player == null:
			player = $"/root/Game/View/Player"
	
		if canMove:
			handle_movement()
		
		if can_shoot == true:
			shoot()

# Handles the default-movement pattern of an enemy
func handle_movement():
	followPlayer()
			
# loop determines which movement should be looped, for example loop = 1 means that the current and the movement before should be looped 
func move(movement_vector, movement_nr, keep_movement, loop): #movement_nr identifies the move-function with a number, so it can be checked with current_movement
	
	if(determine_origin_position == true and movement_nr == current_movement):
		origin_position = position
		desired_position = origin_position + movement_vector
		determine_origin_position = false
		
	if(position.distance_to(desired_position) < 2 and movement_nr == current_movement):# distance_to(vector) < 2 is used because there are minimal differences in the decimal places of position and desired_position, resulting in them never crossing, this makes them able to come across
		if(loop <= 0):
			if !keep_movement:
				current_movement += 1
				
			elif keep_movement:
				speed = 2
				
			determine_origin_position = true
		elif(loop > 0):
			if !keep_movement:
				current_movement -= loop
			elif keep_movement:
				pass
			determine_origin_position = true
		
	
	elif position.distance_to(desired_position) > 2 and movement_nr == current_movement:
	# warning-ignore:return_value_discarded
		#move_and_slide(movement_vector.normalized() * speed)	#movement_vector.normalized() * speed makes the enemy move by its speed and not the vector speed
		move_and_slide(movement_vector.normalized() * speed)
		
	elif current_movement != movement_nr:
		pass	
	
# Checks whether the enemy is inside/near the camera
func check_inside_camera():
	#If the enemy is inside the camera, then active is set to true
	if position.x + $"EntityHitbox/PlayerCollision".shape.extents.x > $"/root/Game/View/Camera".offset.x and position.x + $"EntityHitbox/PlayerCollision".shape.extents.x <= $"/root/Game/View/Camera".offset.x + 1280 + OUTSIDE_BUFFER \
	  and position.y > 0 and position.y + $"EntityHitbox/PlayerCollision".shape.extents.y < 720:
		inside_camera = true
		
	
	#If the enemy spawns above the camera and is OUTSIDE_BUFFER pixels outside of it, this code makes it move
	# NOTE: The outside buffer is important so that the truster doesn't stop for some reason
	elif position.x > $"/root/Game/View/Camera".offset.x and position.x + $"EntityHitbox/PlayerCollision".shape.extents.x < $"/root/Game/View/Camera".offset.x + 1280 \
		and position.y + $"EntityHitbox/PlayerCollision".shape.extents.y + OUTSIDE_BUFFER > 0: 
		handle_movement()
		inside_camera = false

	
	#If the enemy spawns to the right of the camera and is OUTSIDE_BUFFER pixels outside of it, this code makes it move
	elif position.y > 0 and position.y + $"EntityHitbox/PlayerCollision".shape.extents.y < 720  \
		and position.x > $"/root/Game/View/Camera".offset.x + 1280 and position.x + $"EntityHitbox/PlayerCollision".shape.extents.x - OUTSIDE_BUFFER < $"/root/Game/View/Camera".offset.x + 1280:
		handle_movement()
		inside_camera = true
		
	elif position.x <= $"/root/Game/View/Camera".offset.x - OUTSIDE_BUFFER:
		inside_camera = false
			
func onHit():
	health -= 1;
	if(health <= 0):
		player.add_score(score)
		queue_free()
		
func shoot():
	if(shot_ready && can_shoot):
		var newBullet = BULLET.instance()
		newBullet.transform = $Sprite/bulletPosition.global_transform
		newBullet.set_direction("left")
		$"/root/Game/View/BulletsList".add_child(newBullet)
		shot_ready = false
	
func despawn():
	queue_free()

func _on_ShotTimer_timeout():
	shot_ready = true

func _on_Activation_area_body_entered(body):	# If the player enters the activation_area, for further implementation see enemy-classes
	pass
			
func _on_Activation_area_body_exited(body):			# If the player leaves the activation area, for further implementation see enemy-classes
	pass
			
func followPlayer():
	if inside_camera && follow && hasActivation:
		if following:
			movement = position.direction_to(player.position)
			movement = movement.normalized() * (speed)
			move_and_slide(movement)
				
		
func _on_BulletHitbox_area_entered(area):
	if area.is_in_group("bullet"):
			onHit()



