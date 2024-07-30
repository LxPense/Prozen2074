extends Area2D

class_name Bullet

# The speed-vector is used to set the bullet-speed. 
# The first arg is the speed in x-direction, second is speed in y-direction
export var speed: Vector2 = Vector2(15, 15)

# Used to set a default direction if the angle is 0 Rad
# The default direction is right
export var direction: Vector2 = Vector2(1, 0)

# Represents the direction rotated according to the angle-variable
# rotated_direction is then normalized so it doesn't affect the movement 
var rotated_direction: Vector2

# Angle in radiant
export var angle: float = 0

func _ready():
	
	# Is calculated once for every bullet
	rotated_direction = (direction.rotated(angle)).normalized()
	
	
func _physics_process(delta):
	
	# Every frame the global position of the bullet is updated according to the 
	# set rotation (managed by rotated_direction) and the set speed
	global_position += (rotated_direction) * speed
	
# removes bullet when it hits something
func _on_Bullet_area_entered(_area):
	self.queue_free()

# removes bullet when it is outside the screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
