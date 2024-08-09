class_name BaseBulletStrategy
extends Node2D
# This strategy is used to allow various modular bullet-behaviours

# This variable is used to manipulate the degree of the shot
var target: Node2D

func set_target(target: Node2D):
	self.target = target

var BULLET_SCENE = preload("res://Bullets/Bullet.tscn")

# The speed-argument is used to set a custom speed for the bullets
export var speed: int

# This is used to set the strategy of the bullet
# IMPORTANT: When overriding this function, make sure the bullet with the applied behaviour is returned!
func set_bullet_behaviour():
	pass

