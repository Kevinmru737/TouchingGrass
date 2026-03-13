extends CanvasLayer

@onready var dialogue_content = $Control/TextureRect/DialogueContent
@onready var dialogue_anim_player = $AnimationPlayer

var dialogue = {
	"intro": ["Everything is going wrong today, I just want to crawl up and fade into nothingness...",
		"There's so much I need to do, I don't even know where to start *buries face in hands*"],
	"make_the_bed_done": ["I'm done already"],
	"make_the_bed_success": ["Well I guess that wasn't too bad.",
		"Just cleaning the bed makes the room look a lot different.",
		"I even found Captain Tubbie's fish flakes, I wonder how long it's been since he's eaten..."], 
	"feed_the_fish_done": ["He looks happier... I'm glad I found his food"],
	"feed_the_fish_fail": ["That's Captain Tubbie", 
		"I can't remember the last time I fed him..."],
	"feed_the_fish_success": ["I've found the rations Captain.", 
		"That should make you feel better.",
		"Huh... He spit out a battery, I guess he was getting desperate"],
	"turn_on_music_done": ["Groovy"],
	"turn_on_music_fail": ["It's dead, no music."],
	"turn_on_music_success": ["Hopefully the battery still works",
		"*Inserts battery* Hey look at that, it still works!",
		"*Groovy Jazz is now playing*"],
	"sort_books_done": ["A clean shelf makes for a clean mind."],
	"sort_books_fail": ["Ugghh...", 
		"I'm not motivated enough to deal with that right now"],
	"sort_books_success": ["Maybe sorting won't be so bad... ",
		"*quietly hums along with the music*"],
	"clean_garbage_fail": ["Maybe I'll just go back to bed..."],
	"clean_garbage_success": ["Oh last little bit... ok here we go.",
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
	self.hide()
