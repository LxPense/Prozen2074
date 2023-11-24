extends Node


"""
General info:
	This Node is used to control the switching of levels
"""

# This variable always holds the number of the current level. 
# if a level is finished, current_level gets incremented by one
var current_level_num: int = 1

# This is a string-template to use when loading a new level, %d should be replaced with the next level in order
var level_path: String = "res://Level/Levels/Level_%d.tscn"

# This is a string-template to use when adding a new child to the Level_Controller-tree, %d should be replaced with the next level in order
var node_name: String = "Level_%d"

func _ready():
	get_node("Level_1").connect("can_change_level", self, "change_level")


func change_level():
	# Old level is the level, that was just finished.
	# This reference needs to be created, to have a way to remove the finished level after loading the next level
	var finished_level = level_path % current_level_num 
	var finished_node_name = node_name % current_level_num
	current_level_num += 1
	
	# New level path gets concatenated with current_level_num (the level n+1, where n is number of the current level)
	var new_level_path = "res://Level/Levels/Level_%d.tscn" % current_level_num
	# New level actually gets loaded
	var new_node_name: String = node_name % current_level_num
	var new_level = load(new_level_path).instance()
	new_level.name = node_name % current_level_num
	
	# Finished level gets removed, so only one level is present at each time
	# get_child(int num) holt das child_node mit dem index num -> 0 = erstes child im scene_tree von level_controller 
	
	get_child(0).queue_free()
	# The new level gets added to the level_controller-tree
	add_child(new_level)
	get_node(new_node_name).connect("can_change_level", self, "change_level")
	
	pass



