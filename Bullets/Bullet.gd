extends Area2D

export var speed = 200
var direction = "right" # Default direction for bullets is right

func set_direction(_direction):
	direction = _direction

func set_speed(_speed):
	speed = _speed

func _physics_process(delta):
	check_out_of_bounds()
	if(direction == "right"):
		position += transform.x * speed * delta
	if(direction == "left"):
		position -= transform.x * speed * delta 
	if(direction == "left_down"):
		position -= transform.x * speed * delta
		position -= transform.y * speed * delta
	if(direction == "left_up"):
		position -= transform.x * speed * delta
		position += transform.y * speed * delta
	
func check_out_of_bounds():
	if(!$VisibilityNotifier2D.is_on_screen()):
		self.queue_free()
		
func set_bullet_animation(animation):
	$"BulletAnimation".animation = animation

# removes bullet when it hits something
func _on_Bullet_area_entered(_area):
	self.queue_free()
