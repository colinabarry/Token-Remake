class_name Player extends CharacterBody2D

var walk_speed := 100
var jump_velocity := 250
var gravity := 9.8
var default_jump_tokens := 5

# state machine variables
var is_on_ground := false
var num_jumps := 0
var num_jump_tokens := default_jump_tokens
var input_dir := 0.0

@onready var state_machine := $StateMachine as StateMachine
@onready var anim_player := $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	state_machine.init(self)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.input(event)


func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)


func _process(delta: float) -> void:
	state_machine.process(delta)

	velocity.x = input_dir * walk_speed
	velocity.y += gravity

	move_and_slide()
