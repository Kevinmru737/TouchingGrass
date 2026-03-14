extends CanvasLayer

@onready var dialogue_content = $Control/TextureRect/DialogueContent
@onready var dialogue_anim_player = $AnimationPlayer

var dialogue = {
	"intro": ["Ugghh...",
		"Did I fall back asleep?",
		"Everything is still a mess.",
		 "I should clean... but... it's too much...."],
	"make_the_bed_done": ["That's Peanut my teddy bear."],
	"make_the_bed_success": ["I guess that wasn't too bad...",
		"I even found Captain Tubbie's fish flakes.",
		"I wonder how long it's been since he's eaten..."], 
	"feed_the_fish_done": ["He looks happier... I'm glad I found his food"],
	"feed_the_fish_fail": ["That's Captain Tubbie", 
		"I can't remember the last time I fed him...",
		"I'm such a terrible owner...",
		"I'll just lie down for a minute..."],
	"feed_the_fish_success": ["I've found the rations Captain.", 
		"That should make you feel better.",
		"Huh... He spit out a battery, I guess he was getting desperate"],
	"turn_on_music_done": ["Groovy"],
	"turn_on_music_fail": ["It's dead. I can't remember where I put the battery.",
		"I can't find anything in this mess!!!",
		"I'll just lie down for a minute..."],
	"turn_on_music_success": ["*Inserts battery* Hey look at that, it still works!",
		"Hey I wonder where that book I was reading went...",
		"*Groovy Jazz is now playing*"],
	"sort_books_done": ["The clean shelf somehow makes my mind feel cleaner."],
	"sort_books_fail": ["The bookshelf looks so overwhelming to organize...", 
		"I'm not motivated enough to deal with that right now.",
		"I'll just lie down for a minute..."],
	"sort_books_success": ["Sorting goes by quickly with music. ",
		"Cleaning the room seems a lot less daunting now.",
		"*quietly hums along with the music*"],
	"clean_garbage_fail": ["There's so much... I don't even know where to start.",
		"I'll just lie down for a minute..."],
	"clean_garbage_success": ["Ok last little bit... Here we go.",
		"Hey I can open my door freely now.", 
		"Maybe I should step outside..."],
	"grass": ["wow it's grass",
		"amazing"]
		
}
var dialogue_index = 0
var is_dialogue_processing = false  # Add this flag


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



# Must be passed a String corresponding to the dialog option requested
func process_dialogue(option):
	if is_dialogue_processing or not dialogue.has(option):
		return false
	
	is_dialogue_processing = true
	
	if dialogue_index == 0:
		fade_in_dialogue()
	
	if dialogue_index < len(dialogue[option]):
		print("dialogue %s is processing: %d" % [option, dialogue_index])
		dialogue_content.text = dialogue[option][dialogue_index]
		dialogue_index += 1
		is_dialogue_processing = false
		return false
	else:
		dialogue_index = 0
		fade_out_dialogue()
		HoverManager.dialogue_active = false
		is_dialogue_processing = false
		return true

func fade_in_dialogue():
	self.show()
	HoverManager.dialogue_active = true
	dialogue_anim_player.play("fade_in")
	await dialogue_anim_player.animation_finished

func fade_out_dialogue():
	dialogue_anim_player.play("fade_out")
	await dialogue_anim_player.animation_finished
	get_viewport().set_input_as_handled()
	self.hide()
