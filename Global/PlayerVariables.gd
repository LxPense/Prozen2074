extends Node

export var lives = 3

# determines the player position when he is spawning
export var player_spawn_position = Vector2(60, 200)

# Holds the current instance of the player
var player_instance : KinematicBody2D

# is used to allow the player to no disappear when he's not inside the screen : gets managed by Player-node
var screen_exited_expected : bool = false

func set_player_spawn_position(newPlayerPos : Vector2):
	player_spawn_position = newPlayerPos

# Sets a new player position by using a reference to the player (player_instance)
func set_player_position(newPlayerPos: Vector2):
	player_instance.position = newPlayerPos
	
# Enables or disables the player completely and hide him from the view
func change_player_active(active : bool):
	player_instance.set_physics_process(active)
	player_instance.visible = active

func set_lives(_lives):
	lives = _lives

func get_lives():
	return lives
