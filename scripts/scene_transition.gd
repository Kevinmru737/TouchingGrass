extends CanvasLayer

@onready var anim_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()


func fade_to_black():
	anim_player.play("fade_to_black")
	
func fade_from_black():
	anim_player.play("fade_from_black")
