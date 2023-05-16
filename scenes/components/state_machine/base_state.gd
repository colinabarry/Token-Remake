@icon("res://assets/icons/icon_state.png")
class_name BaseState extends Resource

signal transition_started(state_name: String, new_state: BaseState)

@export var animation: String

var player: Player
var state_machine: StateMachine
var possible_next_states: Array[BaseState]


## Called by StateMachine on [new_state] when changing states
func enter() -> void:
	pass
	# player.anim_player.play(animation)


## Called by StateMachine on [current_state] when changing states
func exit() -> void:
	pass


func register_transition(new_state: BaseState, trigger_signal: Signal) -> void:
	possible_next_states.append(new_state)
	trigger_signal.connect(func(): transition_started.emit(resource_name, new_state))
