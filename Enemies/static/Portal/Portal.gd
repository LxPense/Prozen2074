extends "res://Enemies/Enemy.gd"

const BULLET_RANDOMSTUFF = preload("res://Bullets/Bullet_RandomStuff.tscn") 
onready var animation_tree: AnimationTree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

func _init().(100, 0, 3):
	can_shoot = true
	shot_ready = false
	hasActivation = true
	follow = false

func shoot():
	var current_animation = animation_state.get_current_node()
	if(shot_ready && current_animation == "Main"):
		var newBullet = BULLET_RANDOMSTUFF.instance()
		newBullet.transform = $Sprite/bulletPosition.global_transform
		newBullet.set_direction("left")
		$"/root/Game/View/BulletsList".add_child(newBullet)
		shot_ready = false

func _on_Activation_area_body_entered(body):
	if body.is_in_group("player") && hasActivation:
		animation_tree["parameters/conditions/triggered"] = true
