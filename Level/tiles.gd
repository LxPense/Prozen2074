extends Node2D

var tileMap: TileMap

"""
This node acts as group to organize the various tilemaps in use in the specific level

Tilemaps should only be added to this group
"""
 
func set_tilemap(var _tileMap: TileMap):
	tileMap = _tileMap
	
	
