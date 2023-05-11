@icon("res://assets/icons/icon_state_machine_crisp.png")
class_name StateMachine extends Node

var current_state: BaseState

@onready var states := {
	BaseState.State.IDLE: $Idle,
	BaseState.State.WALK: $Walk,
	BaseState.State.FALL: $Fall,
	BaseState.State.JUMP: $Jump,
}


## Gives each state a reference to the player and initializes [current_state] to IDLE
func init(player: Player) -> void:
	for child in get_children():
		child.player = player

	change_state(BaseState.State.IDLE)


## Exits the current state, sets and enters the new state
func change_state(new_state: int) -> void:
	if current_state:
		print(current_state.name, " -> ", states[new_state].name)
		current_state.exit()

	current_state = states[new_state]
	current_state.enter()


## Passes inputs down to the current state, changing state if necessary
func input(event: InputEvent) -> void:
	_get_state_change(current_state.input(event))


## Passes physics_process down to the current state, changing state if necessary
func physics_process(delta: float) -> void:
	_get_state_change(current_state.physics_process(delta))


## Passes process down to the current state, changing state if necessary
func process(delta: float) -> void:
	_get_state_change(current_state.process(delta))


func _get_state_change(new_state: int) -> void:
	if new_state != BaseState.State.NULL:
		change_state(new_state)
