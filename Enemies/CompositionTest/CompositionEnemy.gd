extends KinematicBody2D
class_name CompositionEnemy

func _ready():
	$HurtBoxComponent.set_healthComponent($HealthComponent)
	$MovementComponent.set_values(self, PlayerVariables.player)	

func _on_Area2D_body_entered(body):
	if(body.is_in_group("enemy")):
		print("yes")
	print(body.name)
	if(body.is_in_group("player")):
		print("YES")
	pass

func _on_HitBoxComponent_body_entered(body):
	if body.is_in_group("player"):
		print(PlayerVariables.player.global_position)
		print("Player detect")


func _on_Area2D_area_entered(area):
	if area.is_in_group("player"):
		print(PlayerVariables.player.global_position)
		print("Player detected")


	
# Why not use active = false to track whether the enemy is active?
# As of Godot 3.4.4 it's not possible to use false for checking conditions
# Therefore another condition "not_triggered" is used
func _on_ActivationArea_area_entered(area):
	if (area.is_in_group("player")):
		$VisualComponent/Sprite/AnimationTree["parameters/conditions/triggered"] = true
		$VisualComponent/Sprite/AnimationTree["parameters/conditions/untriggered"] = false
		$MovementComponent.activate_steering(true)

func _on_ActivationArea_area_exited(area):
	if (area.is_in_group("player")):
		$VisualComponent/Sprite/AnimationTree["parameters/conditions/triggered"] = false
		$VisualComponent/Sprite/AnimationTree["parameters/conditions/untriggered"] = true
		$MovementComponent.activate_steering(false)
	
func _on_HealthComponent_notify_enemy_deletion():
	print("Enemy gets deleted")
	queue_free()
