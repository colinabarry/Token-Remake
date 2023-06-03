class_name Player extends CharacterBody2D

@export var max_walk_speed := 175.0
@export var walk_acceleration := 5.0
@export var jump_velocity := -250.0
@export var gravity := 9.8
@export var default_jump_tokens := 50000
@export var fall_loop_sound: AudioStreamWAV

# state machine variables
var is_on_ground := false
var input_dir := 0.0

@onready var spawn_location := position

@onready var state_machine := $StateMachine as StateMachine
@onready var coin_purse := $CoinPurse as CoinPurse
@onready var anim_player := $AnimationPlayer as AnimationPlayer
@onready var ground_detector := $GroundDetector as GroundDetector

@onready var sprite_origin := $SpriteOrigin as Node2D
@onready var coyote_cast := $CoyoteCast as RayCast2D
@onready var collision := $PlayerCollision as CollisionShape2D
@onready var audio_player := $AudioStreamPlayer2D as AudioStreamPlayer2D
@onready var level = preload("res://scenes/levels/scene_manager/scene_manager.tscn")


func _ready() -> void:
	add_to_group("player")
	ground_detector.hit_level_limit.connect(_on_hit_level_limit)

	state_machine.init(self)
	coin_purse.init(self)


func _input(event: InputEvent) -> void:
	# if Input.is_action_just_pressed("level_reset"):
	# 	die()
	if Input.is_action_just_pressed("move_drop"):
		if ground_detector.standing_on_platform:
			collision.disabled = true
			await create_tween().tween_callback(func(): return false).set_delay(0.1).finished
			collision.disabled = false
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


func can_transition_to(
	to_state: BaseState, from_state: BaseState = state_machine.current_state
) -> bool:
	match to_state:
		States.JUMP_STATE:
			return coin_purse.num_jump_tokens > 0
		States.IDLE_STATE:
			# WALK_STATE should not stay in IDLE_STATE in the case that
			# one direction is held, the other direction is pressed, then the first is released
			return not (from_state == States.WALK_STATE and input_dir != 0)

	return false


func on_ground() -> bool:
	return is_on_floor() or coyote_cast.is_colliding()


func move(move_acceleration := walk_acceleration) -> void:
	if input_dir != 0:
		velocity.x = clamp(
			velocity.x + (input_dir * move_acceleration), -max_walk_speed, max_walk_speed
		)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.25)

	if input_dir != 0:
		sprite_origin.scale.x = signf(input_dir)


func stomp(health_component: HealthComponent) -> void:
	if health_component.is_in_group("lump"):
		velocity.y = jump_velocity


func fall(fall_acceleration := gravity) -> void:
	velocity.y += fall_acceleration


func die() -> void:
	get_tree().change_scene_to_packed(level)


func _on_hit_level_limit() -> void:
	audio_player.stream = fall_loop_sound
	audio_player.play()
	position = spawn_location
