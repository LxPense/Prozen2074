extends Node2D
"""
This node is used to spawn bullets freely
"""

onready var bulletStrategy : BaseBulletStrategy
var specificBulletStrategy : BaseBulletStrategy
var target : Node2D

# Used to add a target to the BulletSpawner
func setTarget(var target: Node2D):
	self.target = target

func setBulletStrategy(var specificBulletStrategy):
	bulletStrategy = specificBulletStrategy
	
	# Sets the target of the bulletstrategy
	bulletStrategy.set_target(target)

func execute_Strategy():
	var bullet : Bullet = bulletStrategy.set_bullet_behaviour()	
	
	bullet.global_position = self.global_position + Vector2(20, 0)
	
	spawn_once(bullet)
# Used to set specific types of bullet, for example playerbullets, spacebossbullets...

#func set_bullet_type(var _bullet):
#	BULLET = _bullet


#func spawn_once():
#	var newBullet = BULLET.instance()
#
#	# This sets the bullet_position right after the bulletSpawner, with a slight shift to the right (x = 20)
#	# so the bullet doesn't collide with the entity that spawns it
#	newBullet.global_position = self.global_position + Vector2(20, 0)
#
#	# A vector from the target position (set by the Target-node) and a vector representing
#	# the origin is calculated. This vector represents the difference between these two points
#	var difference = target.position - Vector2(0, 0)
#
#	# The coordinates of the difference-vector are used to calculate the angle between the
#	# origin and the target
#	# NOTE: The bulletSpawner node itself is only used to set the starting-position of the bullet, 
#	# the origin and the target are used to calculate the angle of the bullet
#	newBullet.angle = atan2(difference.y, difference.x)
#	BulletsList.add_child(newBullet)


func spawn_once(var newBullet: Bullet):
	BulletsList.add_child(newBullet)
