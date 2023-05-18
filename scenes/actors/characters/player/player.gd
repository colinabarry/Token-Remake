class_name Player extends CharacterBody2D

var walk_speed := 100
var jump_velocity := 250
var gravity := 9.8
var default_jump_tokens := 5

# state machine variables
var is_on_ground := false
var input_dir := 0.0

@onready var state_machine := $StateMachine as StateMachine
@onready var coin_purse := $CoinPurse as CoinPurse
@onready var anim_player := $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	add_to_group("player")

	state_machine.init(self)
	coin_purse.init(self)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.input(event)


func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)


func _process(delta: float) -> void:
	state_machine.process(delta)

	# TODO: this is gonna make wall hang/jump act a little different if left
	# some ideas:
	# wallhang/other state makes gravity = 0
	# those states just do the opposite of this (wouldn't that cause issues?)
	# use inheritance (GravityState -> BaseState)
	# hmmm
	velocity.x = input_dir * walk_speed
	velocity.y += gravity

	move_and_slide()


func connect_signal_to_callback(signal_name: StringName, callback: Callable) -> bool:
	if state_machine.is_connected(signal_name, callback):
		return false

	state_machine.connect(signal_name, callback)
	return true


# func connect_jump_to_purse(callback: Callable) -> bool:
# 	if state_machine.jumped.is_connected(callback):
# 		return false

# 	state_machine.jumped.connect(callback)
# 	return true


func can_transition_to(new_state: BaseState) -> bool:
	match new_state:
		States.JUMP_STATE:
			return coin_purse.num_jump_tokens > 0

	return false


func die() -> void:
	get_tree().change_scene_to_file("scenes/levels/test_bed.tscn")

# func can_jump() -> bool:
# 	return coin_purse.num_jump_tokens > 0
