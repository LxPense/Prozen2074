extends "res://Bullets/Bullet.gd"

func _ready():
	pick_random_bullet()
	
func pick_random_bullet():
	var animations = ["mug", "flag", "phone", "puree"]
	#set_bullet_animation(animations[randi() % 4])		# picks a random animation out of the animations-list

func _on_Bullet_RandomStuff_area_entered(area):
	if area.name == "bullets":
		queue_free()
		
