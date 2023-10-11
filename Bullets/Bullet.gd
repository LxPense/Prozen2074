extends Area2D

var speed = 200
var direction = "right" # Default direction for bullets is right

func set_direction(_direction):
	direction = _direction

func _physics_process(delta):
	check_out_of_bounds()
	if(direction == "right"):
		position += transform.x * speed * delta
	if(direction == "left"):
		position -= transform.x * speed * delta 

func check_out_of_bounds():
	if position.x > $"/root/Game/View/Camera".offset.x + 1280:
		self.queue_free()
	elif position.x < $"/root/Game/View/Camera".offset.x:
		self.queue_free()
		
		
func set_bullet_animation(animation):
	$"BulletAnimation".animation = animation

# removes bullet when it hits something
func _on_Bullet_area_entered(_area):
	self.queue_free()
