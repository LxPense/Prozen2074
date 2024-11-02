extends Node2D

# This scene is used to load information from JSON-files

var data_file_path : String


func load_json_file(filePath: String):
	var file = File.new()
	var error = file.open(filePath, File.READ)
	
	if(error != OK):
		print("Error when opening file")
		return
	
	var json_string = file.get_as_text()
	file.close()
	
	var json_data = JSON.parse(json_string)
	
	if json_data.error != OK:
		print("Error parsing JSON: ", json_data.error_string)
		return
	
	var data = json_data.result
	return data
	
func _ready():
	pass
