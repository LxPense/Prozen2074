extends Node

var player_visible : bool

# The player's lives and the player's score are managed by the global PlayerVariables and not the Player-scene itself
# This is due to some scenes (for example the HUD), which need to know the amount of lives before the Player get created 
var player_lives
var player_health
var score

# Notifies the HUD that it can change the animation of the player-hearts to depleted
signal heart_depleted(heart, active)

# Used to signal to an act which contains the player that is should reload
# Is used when the player respawns inside an act (because of losing a life)
signal reload_scene_with_player

# determines the player position when he is spawning
export var player_spawn_position = Vector2(60, 200)

# Holds the packedscene of the player
onready var player_instance 

# The actual player
var player : Player

# Is used to allow the player to no disappear when he's not inside the screen : gets managed by Player-node
# The values true and false are set by the ActStateMachine. It decides if the screen exit was expected or not
var screen_exited_expected : bool = false

func _init():
	self.player_health = 3
	self.player_lives = 3
	self.score = 0
	player_instance = preload("res://Player/Player.tscn")
	player = player_instance.instance()
	
"""
# The method spawn_player creates a new instance of the player, it can now be added as a child
# Is used to spawn the player again after scenes are changed, because every time a scene changes all its children
# get deleted, and as such the player. Therefore he needs to be spawned again every new scene 
# (for example every time the game-scene is set as the main scene)
# Attention: The returned player has to be added to the scene-tree afterwards
"""

func spawn_player():
	var _player = player_instance.instance()
	player = _player
	return _player
	
func move_player_to_scene(target_scene: PackedScene):
	if player != null:
		target_scene.add_child(player)
		player.set_process(true)
		player.visible(true)

func remove_player_from_scene():
	if player != null:
		player.get_parent().remove_child(player)
		
func set_player(_player: KinematicBody2D):
	player = _player

func set_player_spawn_position(newPlayerPos : Vector2):
	player_spawn_position = newPlayerPos

# Sets a new player position by using a reference to the player (player)
func set_player_position(newPlayerPos: Vector2):
	if(player != null):
		player.position = newPlayerPos
	
# Enables or disables the player completely and hides him from the view
func change_player_active(active : bool):
	player.set_physics_process(active)
	player_visible = active
	player.visible = player_visible
	
# This is the only method that should be used when changing the score of the player
# The null check makes sure that the method is executed only if the player is already instanciated
func set_score(_score: int):
	if(player != null):
		player.set_score

func add_score(_score: int):
	if(player != null):
		# Add new score to the global score
		score += _score
		# Add new score to the specific player-instance
		player.score = score

# Method that fires the reload_scene_with_player-signal
func reload_act():
	emit_signal("reload_scene_with_player")

func get_lives():
	return player_lives
