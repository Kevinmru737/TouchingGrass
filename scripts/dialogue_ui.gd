extends CanvasLayer

@onready var dialogue_content = $Control/TextureRect/DialogueContent
@onready var dialogue_anim_player = $AnimationPlayer

var dialogue = {
	"intro": ["...","...ugghh...",
		"...did I fall back asleep?","...",
		"Everything's such a mess.",
		"I swear I saw something move...", "...",
		"...no.","...","...let's just...","...do one thing at a time."],
	"make_the_bed_done": ["That's Peanut, my teddy bear."],
	"make_the_bed_success": ["I...",
		"...guess that wasn't too bad.",
		"Oh. I even found Captain Tubbie's fish flakes.",
		"...",
		"...I wonder how long it's been since he's eaten..."], 
	"feed_the_fish_done": ["He looks... happier.",
		"...I'm glad I found his food."],
	"feed_the_fish_fail": ["That's Captain Tubbie.", 
		"I can't remember the last time I fed him..."],
	"feed_the_fish_success": ["I've found the rations, Captain.",
		"*shakes the flake bag*",
		"...there we go.",
		"That should make you feel better.",
		"Huh...?",
		"He spit out a battery... I guess he was getting desperate."],
	"turn_on_music_done": ["*hums along to the Groove*"],
	"turn_on_music_fail": ["It's dead. There's no music."],
	"turn_on_music_success": ["*inserts battery*",
		"...oh hey, would you look at that. It still works!",
		"*plays Groovy Jazz*"],
	"sort_books_done": ["A clean shelf makes for a clean mind."],
	"sort_books_fail": ["...I-I don't think I'm ready to deal with that right now."],
	"sort_books_success": ["That... went by faster than I thought!",
	"I forgot I even had some of these.", "...hm.",
	"...'Reading for Dummies, 2026'.", "...pfft.", "...haha...",
	"I wonder who gave me that."],
	"clean_garbage_fail": ["That's...","...alot.",
	"...maybe I should just go back to bed..."],
	"clean_garbage_success": ["Aaand... there we go.",
		"The room... doesn't smell anymore.",
		"...oh.",
		"Now I can open my door freely too.",
		"...",
		"...I guess...",
		"...I could probably check what's outside for a bit then..."],
	"grass": ["...huh.", "The sun... feels warmer than I last remember.",
	"*touches the grass*",
	"...I'm not sure why I was expecting something magical, but I guess I must've forgot what grass looked like up close.",
	"It's the kind of green that doesn't exist on a screen.",
	"Behind closed walls.",
	"...","...hm.",
	"I don't even know how long I was in there.",
	"It felt long enough for it to feel normal.",
	"Long enough that outside felt like it existed for other people and not me.",
	"...but I did it.",
	"I did the small things. One at a time.",
	"The trash is out. The books are straight. And Captain Tubbie is fed.",
	"It wasn't much. But weirdly...that feels enough to open the door today.",
	"...maybe I'll do it again tomorrow."]
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
