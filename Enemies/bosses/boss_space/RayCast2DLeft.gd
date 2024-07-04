extends RayCast2D

var colliding_object : Object

func _ready():
	if is_colliding():
		colliding_object = get_collider()
		
