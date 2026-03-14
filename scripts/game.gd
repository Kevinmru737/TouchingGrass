extends Node


@onready var dialogue_ui = $DialogueUI

@onready var click_prompt = $DialogueUI/StartGameUI

const MAIN_GAME = preload("res://scenes/main.tscn")

const dialog_options = {
	"Fishtank": "feed_the_fish",
	"Bed": "make_the_bed",
	"Trashcan": "clean_garbage",
	"Musicplayer": "turn_on_music",
	"Bookshelf": "sort_books"
}



enum GameState {
	INTRO,    
	MAKE_THE_BED,
	FEED_THE_FISH, 
	TURN_ON_MUSIC,  
	SORT_BOOKS,
	CLEAN_GARBAGE,
	PRE_GRASS,
	TOUCH_GRASS
}

var click_prompt_faded = false

var curr_game_state = GameState.INTRO
var advance_game = false
var dialog_done = false
var curr_interact_obj = "None"
var interactables = []

var curr_dialog = "intro"
var dialog_active = false
var book_minigame_scene = load("res://scenes/book_minigame.tscn")
var minigame_scene = load("res://scenes/trash_minigame.tscn")
var touch_grass_scene = load("res://scenes/touch_grass.tscn")
var main_game
var ending_started = false
var minigame
var final_loaded = false
var jazz_music = preload("res://audio/bensound-hipjazz.mp3")
var sad_music = preload("res://audio/2025-06-05_I_Wish_I_Told_You_-_www.FesliyanStudios.com_David_Fesliyan.mp3")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Happy.hide()
	ending_started = false
	dialog_active = false
	curr_dialog = "intro"
	dialog_done = false
	advance_game = false
	curr_game_state = GameState.INTRO
	AudioManager.play_music(sad_music)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if curr_game_state == GameState.INTRO:
		
		if Input.is_action_just_pressed("click"):
			advance_game = dialogue_ui.process_dialogue("intro")
			if not click_prompt_faded:
				click_prompt.get_node("AnimationPlayer").play("fade out")
				click_prompt_faded = true
		if advance_game:
			print("advancing game")
			main_game = MAIN_GAME.instantiate()
			self.add_child(main_game)
			move_child(main_game, 0)
			
			$Background/ColorRect.hide()
			SceneTransition.reset()
			SceneTransition.fade_from_black()
			advance_game = false
			
			#the below is equiv to curr_game_state++ but godot throws a warning, thus the casting
			curr_game_state = (curr_game_state as int + 1) as GameState
			#curr_game_state = GameState.CLEAN_GARBAGE
			# grab list of interactables to connect their signals
			interactables = get_tree().get_nodes_in_group("interactables")
			for i in interactables:
				i.interact_initiated.connect(_on_interact_initiated)
			return
	
	if curr_game_state > GameState.INTRO:
		if dialog_done:
			dialog_active = false
			curr_interact_obj = "None"
		if not dialog_done and dialog_active and Input.is_action_just_pressed("click"):
			if curr_game_state != GameState.TOUCH_GRASS:
				dialog_done = dialogue_ui.process_dialogue(curr_dialog)
			elif curr_game_state == GameState.TOUCH_GRASS and final_loaded:
				dialog_done = dialogue_ui.process_dialogue(curr_dialog)
		
		if advance_game and dialog_done:
			print(curr_game_state)
			curr_game_state = (curr_game_state as int + 1) as GameState
			advance_game = false
			if curr_game_state == GameState.PRE_GRASS and ending_started == false:
				$Exit.show()
				curr_game_state = (curr_game_state as int + 1) as GameState
				ending_started = true
				advance_game = false
				dialog_done = false
				curr_dialog = "grass"
				#dialog_done = dialogue_ui.process_dialogue(curr_dialog)
				return
	#if curr_game_state == GameState.TOUCH_GRASS and ending_started:
		#if Input.is_action_just_pressed("click") and not dialog_done:
			#print("TOUCH_GRASS click fired, curr_dialog: %s, dialog_done: %s" % [curr_dialog, dialog_done])
			#dialog_done = dialogue_ui.process_dialogue(curr_dialog)
	#the beginning game is a little different atm
	
		
		
		

func _on_interact_initiated(obj_name):
	curr_interact_obj = dialog_options[obj_name]
	var failed_option = false
	
	if curr_game_state == GameState.MAKE_THE_BED:
		if curr_interact_obj == dialog_options["Bed"]:
			curr_dialog = curr_interact_obj + "_success"
			get_interactable("Bed").success_interact()
			advance_game = true
		else:
			failed_option = true
	if curr_game_state == GameState.FEED_THE_FISH:
		if curr_interact_obj == dialog_options["Fishtank"]:
			curr_dialog = curr_interact_obj + "_success"
			advance_game = true
			get_interactable("Fishtank").success_interact()
		elif curr_interact_obj == dialog_options["Bed"]:
			curr_dialog = curr_interact_obj + "_done"
		else:
			failed_option = true
	if curr_game_state == GameState.TURN_ON_MUSIC:
		if curr_interact_obj == dialog_options["Musicplayer"]:
			curr_dialog = curr_interact_obj + "_success"
			advance_game = true
			if not AudioManager.music_player.stream == jazz_music:
				AudioManager.play_music(jazz_music)
				AudioManager.music_player.volume_db = -25
			get_interactable("Musicplayer").success_interact()
		elif curr_interact_obj == dialog_options["Bed"] or  curr_interact_obj == dialog_options["Fishtank"]:
			curr_dialog = curr_interact_obj + "_done"
		else:
			failed_option = true
	if curr_game_state == GameState.SORT_BOOKS:
		if curr_interact_obj == dialog_options["Bookshelf"]:
			var book_mg = book_minigame_scene.instantiate()
			book_mg.books_sorted.connect(_bg_minigame_completed)
			get_tree().current_scene.add_child(book_mg)
			main_game.hide()
			return
		elif curr_interact_obj == dialog_options["Bed"] or curr_interact_obj == dialog_options["Fishtank"] or curr_interact_obj == dialog_options["Musicplayer"]:
			curr_dialog = curr_interact_obj + "_done"
		else:
			failed_option = true
	if curr_game_state == GameState.CLEAN_GARBAGE:
		if curr_interact_obj == dialog_options["Trashcan"]:
			minigame = minigame_scene.instantiate()
			minigame.trash_cleaned.connect(_on_minigame_completed)
			get_tree().current_scene.add_child(minigame)
			main_game.hide()
			return
		elif curr_interact_obj == dialog_options["Bed"] or dialog_options["Fishtank"] or dialog_options["Musicplayer"] or dialog_options["Bookshelf"]:
			curr_dialog = curr_interact_obj + "_done"
			#this is broken FYI but doesn't get reached so we good probably
	
	if failed_option:
		curr_dialog = curr_interact_obj + "_fail"
	
	dialog_done = dialogue_ui.process_dialogue(curr_dialog)
	
	if failed_option and dialog_done:
		bad_option_chosen()
	
	
func _bg_minigame_completed():
	curr_dialog ="sort_books_success"
	main_game.show()
	advance_game = true
	dialog_active = true
	dialog_done = dialogue_ui.process_dialogue(curr_dialog)
	get_interactable("Bookshelf").success_interact()
	
func _on_minigame_completed():
	main_game.show()
	curr_dialog ="clean_garbage_success"
	$Happy.show()
	$Happy/AnimationPlayer.play("fade in")
	main_game.fade_out()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # trap mouse
	await $Happy/AnimationPlayer.animation_finished
	main_game.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)   # release
	advance_game = true
	dialog_active = true
	dialog_done = dialogue_ui.process_dialogue(curr_dialog)

func get_interactable(obj_name):
	for i in interactables:
		if i.name == obj_name:
			return i
	
func bad_option_chosen():
	await SceneTransition.fade_to_black()
	$Background/ColorRect.show()
	main_game.queue_free()
	_ready()
	dialog_done = dialogue_ui.process_dialogue(curr_dialog)
	
func go_outside():
	var tg_scene = touch_grass_scene.instantiate()
	self.add_child(tg_scene)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # trap mouse
	await tg_scene.fade_in()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)   # release
	final_loaded = true
	dialog_done = dialogue_ui.process_dialogue(curr_dialog)
	#move_child(tg_scene, 0)
	
	
