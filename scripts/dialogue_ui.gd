extends CanvasLayer

@onready var dialogue_content = $Control/Sprite2D/DialogueContent
@onready var dialogue_anim_player = $AnimationPlayer

var dialogue = {
	"intro": ["Dialogue 1. Depression Start",
		"Intro 2nd dialogue, depression continues"],
	"make_the_bed_success": ["Well I guess that wasn't too bad.",
		"Just cleaning the bed makes the room look a lot different.",
		"I even found Captain Tubbie's fish flakes, I wonder how it's been since he's eaten..."], 
	"feed_the_fish_fail": ["That's Captain Tubbie", 
		"I can't remember the last time I fed him..."],
	"feed_the_fish_success": ["I've found the rations Captain.", 
		"That should make you feel better."],
		
}
var dialogue_index = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control.mouse_filter = Control.MOUSE_FILTER_IGNORE  # Let clicks pass through


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



# Must be passed a String corresponding to the dialog option requested
func process_dialogue(option):
	
	if dialogue[option]:
		# fade in new dialogue
		if dialogue_index == 0:
			fade_in_dialogue()
		print("dialoge %s is processing" % option)
		if dialogue_index < len(dialogue[option]):
			dialogue_content.text = dialogue[option][dialogue_index]
			dialogue_index += 1
			return false
		else:
			dialogue_index = 0
			fade_out_dialogue()
			return true

func fade_in_dialogue():
	self.show()
	dialogue_anim_player.play("fade_in")
	await dialogue_anim_player.animation_finished
	
func fade_out_dialogue():
	dialogue_anim_player.play("fade_out")
	await dialogue_anim_player.animation_finished
	self.hide()
