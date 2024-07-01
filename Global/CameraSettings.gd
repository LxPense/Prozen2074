extends Node

var WALL_CURRENT_MOVEMENT = Vector2(0, 0)  

# This variable holds the current camera after _ready() is called upon the camera-node
# It is used to modify the camera inbetween scenes (for example resetting it)
var camera : Camera2D = null

# Shows whether the camera is moving or not
var moving : bool

# Used to apply automatic movement to the player due to the shifting camera
# Used in combination with change_camera_move to stop the movement of the camera and as such the player
func move():
	if(moving):
		return WALL_CURRENT_MOVEMENT
	else:
		return Vector2(0, 0)

# Resets the camera to the coordinates (0, 0)
func reset_camera():
	if(camera != null):
		camera.offset = Vector2(0, 0)
		
# Enables or disables the movement of the camera by activating or disabling it
func change_camera_move(moving : bool):
	self.moving = moving
	camera.set_physics_process(self.moving)
	
