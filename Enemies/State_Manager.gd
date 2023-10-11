extends Node

onready var states = {
	BaseState.State.Null: $null,
	BaseState.State.Idle: $walk,
	BaseState.State.Triggered: $triggered,
	BaseState.State.Attack: $attack
} 

var current_state: BaseState

func change_state(new_state: int) -> void:
	if current_state:
		current_state.exit()
		
	current_state = states[new_state]
	current_state.enter()

"""
func init(enemy: Enemy) -> void:
	for child in get_children():
		child.player = player
		
	change_state(BaseState.State.Idle)
"""

func _physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state != BaseState.State.Null:
		change_state(new_state)

func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	if new_state != BaseState.State.Null:
		change_state(new_state)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
