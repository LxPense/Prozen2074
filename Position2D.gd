extends Position2D
	
var enemy = preload("res://Enemies/dynamic/FlamingSkull/FlamingSkull.tscn")	
	
func _ready():
	var e = enemy.instance()
	get_parent().add_child(e)
