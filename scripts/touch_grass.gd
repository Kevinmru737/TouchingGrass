extends CanvasLayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func fade_in():
	animation_player.play("fade_in")
	await animation_player.animation_finished
