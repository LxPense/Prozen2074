extends Node2D

"""
This node is used to spawn bullets freely
"""

# The direction-argument sets the direction of the bullet
# Possible directions are: left, right

export var direction: String

# The speed-argument is used to set a custom speed for the bullets

export var speed: int

var BULLET = preload("res://Bullets/Bullet_Spaceboss.tscn")

func spawn_once():
	var newBullet = BULLET.instance()
	newBullet.transform = global_transform
	newBullet.set_direction(direction)
	newBullet.set_speed(speed)
	
	$"/root/Game/View/BulletsList".add_child(newBullet)
