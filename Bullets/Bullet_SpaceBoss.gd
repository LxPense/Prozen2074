extends "res://Bullets/Bullet.gd"


func _ready():
	pass


func _on_Bullet_SpaceBoss_area_entered(_area):
	self.queue_free()
