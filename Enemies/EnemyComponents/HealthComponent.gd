extends Node2D
class_name HealthComponent

# Default health value
export var default_health: int = 10

var current_health : int

# Is used to notifiy the CompositionEnemy that the enemy can be deleted because it has lost its health
signal notify_enemy_deletion

func _ready():
	current_health = default_health

func set_current_health(var _current_health: int):
	self.current_health = current_health

func get_current_health() -> int:
	return current_health

func change_current_health(var change_amt):
	current_health += change_amt
	
	if(current_health <= 0):
		print("Health lower or equal to 0")
		emit_signal("notify_enemy_deletion")
		
