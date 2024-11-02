extends Area2D
class_name HurtBoxComponent


# IMPORTANT: For this component to work properly the healthComponent-variable has to be set
# Because Godot 3.4 doesn't allow custom export-variables, the healthComponent has to be set
# outisde of the HurtBoxComponent-script

# Requires a HealthComponent
var healthComponent : HealthComponent

func set_healthComponent(var _healthComponent : HealthComponent):
	healthComponent = _healthComponent

func _ready():
	pass

func _on_HurtBoxComponent_area_entered(area):
	healthComponent.change_current_health(-10)
	print("Enemy hit!")
