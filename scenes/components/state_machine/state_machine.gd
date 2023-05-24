@icon("res://assets/icons/icon_state_machine.png")
class_name StateMachine extends Node

signal started_walking
signal stopped_walking_on_ground
signal stopped_walking_in_air
signal jumped
signal started_falling
signal stopped_touching_ground
signal started_touching_ground_moving
signal started_touching_ground_unmoving

@export var states := [] as Array[BaseState]

var current_state: BaseState

@onready var player: Player


## Gives each state a reference to the player and initializes [current_state] to IDLE
func init(_player: Player) -> void:
	self.player = _player

	_register_state(
		States.IDLE_STATE,
		{
			States.WALK_STATE: started_walking,
			States.JUMP_STATE: jumped,
			States.FALL_STATE: stopped_touching_ground,
		}
	)
	_register_state(
		States.WALK_STATE,
		{
			States.IDLE_STATE: stopped_walking_on_ground,
			States.JUMP_STATE: jumped,
			States.FALL_STATE: stopped_walking_in_air,
			States.FALL_STATE: stopped_touching_ground,  # FIXME: you can't seem to define a second transition like this
		}
	)
	_register_state(
		States.FALL_STATE,
		{
			States.WALK_STATE: started_touching_ground_moving,
			States.IDLE_STATE: started_touching_ground_unmoving,
		}
	)
	_register_state(
		States.JUMP_STATE,
		{
			States.FALL_STATE: started_falling,
		}
	)

	change_state(States.IDLE_STATE)


## Exits the current state, sets and enters the new state
func change_state(new_state: BaseState) -> void:
	if current_state:
		# print_debug(current_state.resource_name, " -> ", new_state.resource_name)
		current_state.exit()

	current_state = new_state
	current_state.enter()


func input(_event: InputEvent) -> void:
	player.input_dir = (
		-Input.get_action_strength("move_left") + Input.get_action_strength("move_right")
	)

	_emit_input_signals()


func physics_process(_delta: float) -> void:
	pass


func process(_delta: float) -> void:
	_emit_process_signals()


func try_state_change(state_name: String, new_state: BaseState) -> void:
	if current_state.resource_name == state_name:
		change_state(new_state)  # TODO: make sure state transition is valid


func _register_state(new_state: BaseState, transitions: Dictionary) -> bool:
	# guard against duplicate state
	if states.has(new_state):
		return false

	# give the state a reference to the player as well as the state machine
	new_state.player = player
	new_state.state_machine = self

	# register all state transitions
	# each transition will cause the state to emit [transition_started(state_name, new_state)]
	# [state_name] is the sending state's resource_name
	for transition_key in transitions.keys() as Array[BaseState]:
		new_state.register_transition(transition_key, transitions[transition_key] as Signal)

	# connect the state's transition_started signal to try_state_change
	new_state.transition_started.connect(try_state_change)

	# new_state.register_transition(try_state_change)
	states.append(new_state)
	return true


func _emit_input_signals() -> void:
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		started_walking.emit()
	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		if player.is_on_ground:
			stopped_walking_on_ground.emit()
		else:
			stopped_walking_in_air.emit()
	if Input.is_action_just_pressed("move_jump"):
		_try_emit_signal(States.JUMP_STATE, jumped)


func _emit_process_signals() -> void:
	if player.is_on_ground and not player.is_on_floor():
		player.is_on_ground = false  # TODO: move this into player, listen for signal?
		stopped_touching_ground.emit()
	if not player.is_on_ground and player.is_on_floor():
		player.is_on_ground = true  # TODO: see above :)
		if player.input_dir == 0:
			started_touching_ground_unmoving.emit()
		else:
			started_touching_ground_moving.emit()
	if current_state is JumpState and player.velocity.y >= 0:
		started_falling.emit()


func _try_emit_signal(new_state: BaseState, signal_to_emit: Signal) -> bool:
	if not current_state.possible_next_states.has(new_state):
		return false
	if not player.can_transition_to(new_state):
		return false

	signal_to_emit.emit()
	return true
