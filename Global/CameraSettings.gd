extends Node

var WALL_CURRENT_MOVEMENT = Vector2(0, 0)  

# This variable holds the current camera after _ready() is called upon the camera-node
# It is used to modify the camera inbetween scenes (for example resetting it)
var camera : Camera2D = null

# Resets the camera to the coordinates (0, 0)
func reset_camera():
	if(camera != null):
		camera.offset = Vector2(0, 0)
		
		#PlayerVariables.screen_exited_expected = true
		
# Enables or disables the movement of the camera by activating or disabling it
func change_camera_move(moving : bool):
	camera.set_physics_process(moving)
	
