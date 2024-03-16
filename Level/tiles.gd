extends Node2D

var tileMap: TileMap

"""
This node acts as group to organize the various tilemaps in use in the specific level

Tilemaps should only be added to this group
"""
 
func change_collision(active: bool):

	#If true, the player-collision is working (note: the player-collision gets handled with the 4. mask, which is bit 3)
	if(active):
		get_node("TileMap_1").set_collision_layer_bit(1, true)
		get_node("TileMap_2").set_collision_layer_bit(1, true)
	
	#If false the player-collision is not working
	elif(!active):
		get_node("TileMap_1").set_collision_layer_bit(1, false)
		get_node("TileMap_2").set_collision_layer_bit(1, false)


func set_tilemap(var _tileMap: TileMap):
	tileMap = _tileMap
