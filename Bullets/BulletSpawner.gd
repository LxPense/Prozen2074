extends Node2D
class_name BulletSpawner
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

func spawn_once(var newBullet: Bullet):
	BulletsList.add_child(newBullet)
