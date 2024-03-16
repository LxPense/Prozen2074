extends Area2D


# Function to enable and disable the EndMarker

func set_marker_active(enabled: bool):
	if(enabled):
		monitoring = true
	
	elif(!enabled):
		monitoring = false
