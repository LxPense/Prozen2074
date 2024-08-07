extends Control

# This scene is used to change the individual scenes in the game, it controls everything scene-wise
# (Except the switching of levels inside the Game-scene, this gets managed by the Game-scene itself

# current_scene is the scene that is displayed right now
var current_scene : PackedScene

# selection of all scenes
onready var menu_scene : PackedScene
onready var game_scene : PackedScene
onready var continue_scene : PackedScene

onready var scenes = {
	"scene_menu": "res://UI/Menu.tscn",
	"scene_game": "res://Game.tscn",
	"scene_continue": "res://Continue.tscn"
}

var loaded_scenes = {}

func _ready():
	
	# The scenes get initialized by the paths inside the scenes-dictionary
	menu_scene = load(scenes["scene_menu"])
	loaded_scenes["scene_menu"] = menu_scene
	game_scene = load(scenes["scene_game"])
	loaded_scenes["scene_game"] = game_scene
	continue_scene = load(scenes["scene_continue"]) 
	loaded_scenes["scene_continue"] = continue_scene
	
	
	
func change_current_scene(scene_name):
	
	# This is needed because during the change of the scene the VisibilityNotifier of the player is notified
	# that the player isn't inside the screen anymore, therefore the menu-scene is loaded automatically.
	# By setting screen_exited_expected to true the aforementioned behaviour will be ignored
	# IMPORTANT: the screen_exited_expected-flag has to be turned off after using the change_current_scene-method! 
	
	current_scene = loaded_scenes[scene_name]
	get_tree().change_scene(scenes[scene_name])
	
	
func reload_current_scene():
	pass
	#TODO: Finish this crap
