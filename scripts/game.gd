extends Node


@onready var dialogue_ui = $DialogueUI


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
	TOUCH_GRASS
}

var curr_game_state = GameState.INTRO
var advance_game = false
var dialog_done = false
var interactables = []
var curr_interact_obj = "None"

var curr_dialog = "intro"
var dialog_active = false
var minigame_scene = load("res://scenes/trash_minigame.tscn")
var touch_grass_scene = load("res://scenes/touch_grass.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if curr_game_state == GameState.INTRO:
		
		if Input.is_action_just_pressed("click"):
			advance_game = dialogue_ui.process_dialogue("intro")
		if advance_game:
			print("advancing game")
			var main_game = MAIN_GAME.instantiate()
			self.add_child(main_game)
			move_child(main_game, 0)
			$Background/ColorRect.hide()
			SceneTransition.reset()
			SceneTransition.fade_from_black()
			advance_game = false
			curr_game_state += 1
			
			# grab list of interactables to connect their signals
			var interactables = get_tree().get_nodes_in_group("interactables")
			for i in interactables:
				i.interact_initiated.connect(_on_interact_initiated)
			return
	
	if curr_game_state > GameState.INTRO:
		if dialog_done:
			dialog_active = false
			curr_interact_obj = "None"
		if not dialog_done and dialog_active and Input.is_action_just_pressed("click") :
			dialog_done = dialogue_ui.process_dialogue(curr_dialog)
		
		if advance_game and dialog_done:
			print(curr_game_state)
			curr_game_state += 1
			advance_game = false
			if curr_game_state == GameState.TOUCH_GRASS:
				get_tree().current_scene.add_child(touch_grass_scene.instantiate())
	#the beginning game is a little different atm
	
		
		
		

func _on_interact_initiated(name):
	curr_interact_obj = dialog_options[name]
	var failed_option = false
	
	if curr_game_state == GameState.MAKE_THE_BED:
		if curr_interact_obj == dialog_options["Bed"]:
			curr_dialog = curr_interact_obj + "_success"
			advance_game = true
		else:
			failed_option = true
	if curr_game_state == GameState.FEED_THE_FISH:
		if curr_interact_obj == dialog_options["Fishtank"]:
			curr_dialog = curr_interact_obj + "_success"
			advance_game = true
		elif curr_interact_obj == dialog_options["Bed"]:
			curr_dialog = curr_interact_obj + "_done"
		else:
			failed_option = true
	if curr_game_state == GameState.TURN_ON_MUSIC:
		if curr_interact_obj == dialog_options["Musicplayer"]:
			curr_dialog = curr_interact_obj + "_success"
			advance_game = true
		elif curr_interact_obj == dialog_options["Bed"] or  curr_interact_obj == dialog_options["Fishtank"]:
			curr_dialog = curr_interact_obj + "_done"
		else:
			failed_option = true
	if curr_game_state == GameState.SORT_BOOKS:
		if curr_interact_obj == dialog_options["Bookshelf"]:
			curr_dialog = curr_interact_obj + "_success"
			advance_game = true
		elif curr_interact_obj == dialog_options["Bed"] or curr_interact_obj == dialog_options["Fishtank"] or curr_interact_obj == dialog_options["Musicplayer"]:
			curr_dialog = curr_interact_obj + "_done"
		else:
			failed_option = true
	if curr_game_state == GameState.CLEAN_GARBAGE:
		if curr_interact_obj == dialog_options["Trashcan"]:
			var minigame = minigame_scene.instantiate()
			minigame.trash_cleaned.connect(_on_minigame_completed)
			get_tree().current_scene.add_child(minigame)
			return
		elif curr_interact_obj == dialog_options["Bed"] or dialog_options["Fishtank"] or dialog_options["Musicplayer"] or dialog_options["Bookshelf"]:
			curr_dialog = curr_interact_obj + "_done"
			
	
	if failed_option:
		curr_dialog = curr_interact_obj + "_fail"
	
	dialog_done = dialogue_ui.process_dialogue(curr_dialog)
	
func _on_minigame_completed():
	curr_dialog ="clean_garbage_success"
	advance_game = true
	dialog_active = true
	dialog_done = dialogue_ui.process_dialogue(curr_dialog)

	
