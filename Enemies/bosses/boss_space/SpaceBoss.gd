extends Node2D

# Threshold how many shots the boss fires while floating down
var shots_threshold = 5

# Counts the current shots
var shots_amount = 0

# Holds the current position of the boss, used for performing the jump
var boss_position = position

# Acts as a flag for the move_and_slide-function.
# While this flag is active, the boss is able to perform the jump
var jumping: bool = false

var velocity := Vector2.ZERO

# Various variables that are needed for the jump-physics
export var timeToJumpPeak : float = .5
export var jumpHeight : int = 128

var GRAVITY : float = (2*jumpHeight)/pow(timeToJumpPeak, 2)
var JUMP_SPEED : float = GRAVITY * timeToJumpPeak

onready var _anim_tree = $AnimationTree

func ready():
	pass

func increase_shot_amount():
	shots_amount += 1

# The whole jumping-mechanic
func jump():
	velocity.y = -JUMP_SPEED

# Decides, whether the boss has hit the apex
func enable_apex(var is_at_apex: bool):
	$AnimationTree["parameters/conditions/atapex"] = is_at_apex
	
func enable_shots_fired(var has_fired_shots: bool):
	$AnimationTree["parameters/conditions/shots_fired"] = has_fired_shots

func _physics_process(delta):
	jump()
	

# This function is part of the SpaceBoss_shoot animation inside the animation-tree
# When the boss has fired more than 3 shots, the shots_fired condition inside the animation-tree
# is set to true, and as such the animation traverses to the SpaceBoss_reload-animation
func check_for_reload():
	if(shots_amount >= shots_threshold):
		
		#Shots get immediately reset to 0, so the whole thing can be reused
		shots_amount = 0
		enable_shots_fired(true)


# Is used to start the animaion when the boss enters the screen
# The animation-tree does NOT automatically start the animation!
func _on_VisibilityNotifier2D_screen_entered():
	$AnimationTree.get("parameters/playback").travel("idle")
