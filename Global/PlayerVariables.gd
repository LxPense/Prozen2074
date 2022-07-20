extends Node

export var lives = 3

#holds the current player position, always gets updated via the Player node
export var player_position = Vector2(0,0)

func set_lives(_lives):
	lives = _lives
	
func get_lives():
	return lives
