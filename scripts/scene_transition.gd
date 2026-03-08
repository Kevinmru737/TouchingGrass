extends CanvasLayer

@onready var anim_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()


func fade_to_black():
	self.show()
	anim_player.play("fade_to_black")
	await anim_player.animation_finished
	self.hide()
	
func fade_from_black():
	self.show()
	anim_player.play("fade_from_black")
	await anim_player.animation_finished
	self.hide()
	
func reset():
	self.show()
	anim_player.play("RESET")
