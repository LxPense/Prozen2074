class_name ActStateMachine
extends Node

signal transitioned(state_name)

export var initial_state := NodePath()

onready var state: ActState = get_node(initial_state)
onready var act1 = get_node("Act1")
onready var act2 = get_node("Act2")
onready var act_boss = get_node("Boss")
onready var act_finished = get_node("Finished")

# Holds a reference to the current playing act
var current_act = null

func _ready():
	act1.connect("act1_finished", self, "_on_Act1_act_finished")
	act2.connect("act2_finished", self, "_on_Act2_act_finished")
	act_boss.connect("act_boss_finished", self, "_on_Boss_act_finished")
	act_finished.connect("act_end_finished", self, "_on_Finished_act_finished")
	
	# Note: The first act (act1) isn't deactivated because it's the starting act
	
	deactivate_act(act2)
	deactivate_act(act_boss)
	deactivate_act(act_finished)
		
	current_act = initial_state
	
	yield(owner, "ready")
	
	# The same state-machine is applied to every state
	
	for child in get_children():
		child.state_machine = self
	
	# The first call of the enter-Function: This is used to enter the first act
	state.set_process(true)
	activate_act(act1)
	state.enter();
	
"""
This function deactivates everything inside an act (it works recursively)
This function is therefore used to prevent the various acts to influence each other, as they are 
all inside the scene-tree. 
"""

func deactivate_act(node : Node2D):
	if node is ParallaxLayer:
		node.visible = false	
	elif node is Area2D:
		node.hide()
		node.set_monitoring(false)
		node.visible = false
	elif node is TileMap:
		var tempTileMap = node as TileMap
		tempTileMap.visible = false
		tempTileMap.set_collision_layer_bit(1, 0)
		
	# Each node of an act further down the scene-tree that has children is called recursively
	if(node != null && node.get_child_count() != 0):
		for child in node.get_children():
			deactivate_act(child)

""""
 This function activates everything inside an act (it works recursively)
 This function is therefore used to prevent the various acts to influence each other, as they are 
 all inside the scene-tree
"""

func activate_act(node):
	if node is ParallaxLayer:
		node.visible = true	
	elif node is Area2D:
		node.show()
		node.set_monitoring(true)
		node.visible = true
	elif node is TileMap:
		var tempTileMap = node as TileMap
		tempTileMap.visible = true
		tempTileMap.set_collision_layer_bit(1, 2)
	
	
	if(node != null && node.get_child_count() != 0):
		for child in node.get_children():
			activate_act(child)
		

func _unhandled_input(event: InputEvent):
	state.handle_input(event)

func _process(delta):
	state.update(delta)
		
func _physics_process(delta):
	state.physics_update(delta)
	
# Is used to enter various acts, but not the first one (entering the first one is handled seperately)
func transition_to(target_state_name) -> void:
	if not has_node(target_state_name):
		return 
	
	# exit-function is called on the currrent act
	state.exit()
	deactivate_act(target_state_name)
	# After the previous state has exited, it is removed from the scene tree
	remove_child(state)
	
	state = get_node(target_state_name)
	current_act = state
	activate_act(state)
	
	state.enter()

func _on_Act1_act_finished():
	transition_to(act2.get_path())

func _on_Act2_act_finished():
	transition_to(act_boss.get_path())

func _on_Boss_act_finished():
	transition_to(act_finished.get_path())

func _on_Finished_act_finished():
	print("Change level")
