extends CanvasLayer

@onready var dialogue_content = $Control/Sprite2D/DialogueContent
@onready var dialogue_anim_player = $AnimationPlayer

var dialogue = {
	"intro": ["Dialogue 1. Depression Start",
		"Intro 2nd dialogue, depression continues"]
}
var dialogue_index = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



# Must be passed a String corresponding to the dialog option requested
func process_dialogue(option):
	
	if dialogue[option]:
		# fade in new dialogue
		if dialogue_index == 0:
			dialogue_anim_player.play("fade_in")
		print("dialoge %s is processing" % option)
		if dialogue_index < len(dialogue[option]):
			dialogue_content.text = dialogue[option][dialogue_index]
			dialogue_index += 1
		else:
			dialogue_index = 0
			dialogue_anim_player.play("fade_out")
	
