extends KinematicBody2D

# Threshold how many shots the boss fires while floating down
var shots_threshold = 5

# Counts the current shots
var shots_amount = 0

# Holds the current position of the boss, used for performing the jump
var boss_position = position

# Acts as a flag for the move_and_slide-function.
# While this flag is inactive, the boss is able to perform the jump
var jumping: bool = false

var velocity := Vector2.ZERO

# Various variables that are needed for the jump-physics
#export var timeToJumpPeak : float = .5
#export var jumpHeight : int = -200


#Text with new physics
export var jump_height: float
export var jump_time_to_peak: float
export var jump_time_to_descent: float

onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

onready var _anim_tree = $AnimationTree

func get_gravity() -> float:
	if(velocity.y < 0.0):
		return jump_gravity
	else:
		return fall_gravity
	 
func ready():
	pass

func increase_shot_amount():
	shots_amount += 1

# The whole jumping-mechanic
func jump():
	if(jumping && is_on_floor()):
		velocity.y = jump_velocity


# Used to set the jumping-flag from the AnimationTree, as it can only call methods, but not change variables
func is_jumping(var should_jump):
	jumping = should_jump

# Decides, whether the boss has hit the apex
func enable_apex(var is_at_apex: bool):
	$AnimationTree["parameters/conditions/atapex"] = is_at_apex
	
func enable_shots_fired(var has_fired_shots: bool):
	$AnimationTree["parameters/conditions/shots_fired"] = has_fired_shots

func _physics_process(delta):
	
	velocity.y += get_gravity() * delta
	
	jump()
	
	# If the velocity is 0, and thus the boss is at the apex, the Animation-Tree can proceed to the shootready-animation
	if(round(velocity.y) == 0):
		enable_apex(true)
		
	velocity = move_and_slide(velocity, Vector2.UP)
	

# This function is part of the SpaceBoss_shoot animation inside the animation-tree
# When the boss has fired more than 3 shots, the shots_fired condition inside the animation-tree
# is set to true, and as such the animation traverses to the SpaceBoss_reload-animation
func check_for_reload():
	if(shots_amount >= shots_threshold):
		
		#Shots get immediately reset to 0, so the whole thing can be reused
		shots_amount = 0
		enable_shots_fired(true)

func change_scroll(var scrolling: bool):
	CameraSettings.change_camera_move(scrolling)
	

# Is used to start the animaion when the boss enters the screen
# The animation-tree does NOT automatically start the animation!
func _on_VisibilityNotifier2D_screen_entered():
	$AnimationTree.get("parameters/playback").travel("idle")	

