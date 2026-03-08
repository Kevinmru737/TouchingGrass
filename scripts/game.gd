extends Node


@onready var dialogue_ui = $DialogueUI

enum GameState {
	INTRO,    
	MAKE_THE_BED,
	FEED_THE_FISH, 
	TURN_ON_MUSIC,  
	SORT_BOOKS,
	CLEAN_GARBAGE
}

var curr_game_state = GameState.INTRO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if curr_game_state == GameState.INTRO:
		
		if Input.is_action_just_pressed("click"):
			dialogue_ui.process_dialogue("intro")
	elif curr_game_state == GameState.MAKE_THE_BED:
		pass
	elif curr_game_state == GameState.FEED_THE_FISH:
		pass
	elif curr_game_state == GameState.TURN_ON_MUSIC:
		pass
	elif curr_game_state == GameState.SORT_BOOKS:
		pass
	elif curr_game_state == GameState.CLEAN_GARBAGE:
		pass
		
