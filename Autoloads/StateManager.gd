extends Node

signal state_changed(old_state, new_state)

enum state {
	MAIN_MENU,
	PLAYING,
	END_TURN,
	PAUSED,
	GAME_OVER
}

enum card_state {
	DEFAULT, # ---> this is the unselected state, I may need to change the name to something else
	SELECTED,
	HELD
}

enum tile_state {
	DEFAULT, # ---> this is the unselected state, I may need to change the name to something else
	SELECTED,
}

var current_state = state.MAIN_MENU
var old_state = state.MAIN_MENU

func change_state(new_state):
	old_state = current_state
	current_state = new_state
	emit_signal("state_changed", old_state, new_state)

func revert_state():
	var tmp = current_state
	current_state = old_state
	emit_signal("state_changed", tmp, current_state)
