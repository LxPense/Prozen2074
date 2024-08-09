class_name NormalShotBulletStrategy
extends BaseBulletStrategy

func set_bullet_behaviour():
	var newBullet : Bullet  = BULLET_SCENE.instance()
	# A vector from the target position (set by the Target-node) and a vector representing
	# the origin is calculated. This vector represents the difference between these two points
	var difference = target.position - Vector2(0, 0)
	
	# The coordinates of the difference-vector are used to calculate the angle between the
	# origin and the target
	# NOTE: The bulletSpawner node itself is only used to set the starting-position of the bullet, 
	# the origin and the target are used to calculate the angle of the bullet
	newBullet.angle = atan2(difference.y, difference.x)
	
	# The specific behaviour was applied to the bullet, it can now be handled by the bulletspawner
	return newBullet



