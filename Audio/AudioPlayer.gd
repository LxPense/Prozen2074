extends Node2D


func _ready():
	pass

func play_audio():
	$SoundPlayer.play()

func set_audio(audio_path):
	$SoundPlayer.stream = "res://Assets/Audio/laser_sound.mp3"
