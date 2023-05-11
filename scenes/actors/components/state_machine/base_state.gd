@icon("res://assets/icons/icon_state_crisp.png")
class_name BaseState extends Node

enum State {
	NULL,
	IDLE,
	WALK,
	FALL,
	JUMP,
}

@export var animation: String

var player: Player
var input_dir_x: float


## Called by StateMachine on [new_state] when changing states
func enter() -> void:
	player.anim_player.play(animation)


## Called by StateMachine on [current_state] when changing states
func exit() -> void:
	pass


func input(_event: InputEvent) -> int:
	return State.NULL


func physics_process(_delta: float) -> int:
	return State.NULL


func process(_delta: float) -> int:
	return State.NULL
