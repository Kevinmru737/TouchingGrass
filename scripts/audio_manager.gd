extends Node

@onready var sfx_player = AudioStreamPlayer.new()
@onready var music_player = AudioStreamPlayer.new()

func _ready():
	add_child(sfx_player)
	add_child(music_player)

func play_sound(sound: AudioStream):
	sfx_player.stream = sound
	sfx_player.play()

func play_music(sound: AudioStream):
	music_player.volume_db = -20
	music_player.stream = sound
	music_player.stream.loop = true  # add this
	print(sound)
	music_player.play()
