extends Node

@onready var sfx_player = AudioStreamPlayer.new()

func _ready():
	add_child(sfx_player)

func play_sound(sound: AudioStream):
	sfx_player.stream = sound
	sfx_player.play()
