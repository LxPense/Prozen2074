extends "res://Enemies/Enemy.gd"

var laser_loaded = false
var laser_fired = false
export var movement_type = 0

func _init().(150, 150, 2):
	shot_ready = false
	$"ShotTimer".start() #This prevents the laser from firing immediately

func handle_movement():
	if movement_type == 0:
		move(Vector2(0, 420), 1, false, 0)
		move(Vector2(0, 70), 2, false, 0)
		move(Vector2(0, -70), 3, false, 1)
		can_shoot_at(2)
		
	elif movement_type == 1:
		move(Vector2(0, 280), 1, false, 0)
		move(Vector2(0, 10), 2, false, 0)
		can_shoot_at(2)
		
	elif movement_type == 2:
		move(Vector2(0, 405), 1, false, 0)
		move(Vector2(0, 10), 2, false, 0)
		can_shoot_at(2)
		
	elif movement_type == 3:
		move(Vector2(0, 188*3), 1, false, 0)
		move(Vector2(0, 10), 2, false, 0)
		can_shoot_at(2)
		
	elif movement_type == 4:
		move(Vector2(-400, 0), 1, false, 0)
		move(Vector2(10, 0), 2, true, 0)
		can_shoot_at(1)
		
func shoot():
	if shot_ready:
		shot_ready = false
		$"Laser/LaserParticles".emitting = true
		$"Laser/LaserHitbox/LaserAnimation".play("load_laser") #after this it is checked whether the load_laser animation is finished
	elif laser_loaded:	
		laser_loaded = false
		$"AnimatedSprite".play("triggered")
		$"Laser/LaserParticles".emitting = false
		$"Laser/LaserHitbox/LaserAnimation".play("fire_laser")
		$"Laser/LaserHitbox".disabled = false
	elif laser_fired:
		laser_fired = false
		$"AnimatedSprite".play("idle")
		$"Laser/LaserHitbox/LaserAnimation".play("idle")
		$"ShotTimer".start()
		
func _on_LaserAnimation_animation_finished():
	if $"Laser/LaserHitbox/LaserAnimation".animation.begins_with("load_laser"):
		laser_loaded = true
	if $"Laser/LaserHitbox/LaserAnimation".animation.begins_with("fire_laser"):
		laser_fired = true
		$"Laser/LaserHitbox".disabled = true
