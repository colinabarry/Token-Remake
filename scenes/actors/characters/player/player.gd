class_name Player extends CharacterBody2D

@export var max_walk_speed := 150.0
@export var walk_acceleration := 5.0
@export var jump_velocity := 250.0
@export var gravity := 9.8
@export var default_jump_tokens := 50000

# state machine variables
var is_on_ground := false
var input_dir := 0.0

@onready var state_machine := $StateMachine as StateMachine
@onready var coin_purse := $CoinPurse as CoinPurse
@onready var anim_player := $AnimationPlayer as AnimationPlayer

@onready var sprite_origin := $SpriteOrigin as Node2D
@onready var coyote_cast := $CoyoteCast as RayCast2D


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
	# velocity.x = input_dir * walk_speed
	# velocity.y += gravity

	move_and_slide()


func connect_signal_to_callback(signal_name: StringName, callback: Callable) -> bool:
	if state_machine.is_connected(signal_name, callback):
		return false

	state_machine.connect(signal_name, callback)
	return true


func can_transition_to(new_state: BaseState) -> bool:
	match new_state:
		States.JUMP_STATE:
			return coin_purse.num_jump_tokens > 0

	return false


func on_ground() -> bool:
	return is_on_floor() or coyote_cast.is_colliding()


func move(move_acceleration := walk_acceleration) -> void:
	if input_dir != 0:
		velocity.x = clamp(
			velocity.x + (input_dir * move_acceleration), -max_walk_speed, max_walk_speed
		)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.5)

	print_debug(input_dir)
	if input_dir != 0:
		sprite_origin.scale.x = signf(input_dir)


func fall(fall_acceleration := gravity) -> void:
	velocity.y += fall_acceleration


func die() -> void:
	get_tree().change_scene_to_file("scenes/levels/test_bed.tscn")
