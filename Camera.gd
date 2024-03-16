extends Camera2D

var WALL_SPEED = 2
var WALL_MOVEMENT = Vector2(1, 0)
var WALL_CURRENT_MOVEMENT = Vector2(0, 0)

func _ready():
	CameraSettings.camera = self
	 
func _physics_process(delta):
	calculate_current_speed()
	move_wall(delta)
	
# The "wall" is just the left side of the camera, which acts as a boundary for the player and pushes him forward	
func move_wall(_delta): 
	offset += WALL_CURRENT_MOVEMENT
	pass
	
func calculate_current_speed():
	WALL_CURRENT_MOVEMENT = WALL_MOVEMENT * WALL_SPEED
	CameraSettings.WALL_CURRENT_MOVEMENT = WALL_CURRENT_MOVEMENT

func reset_camera_position():
	offset = Vector2(0, 0)
	

