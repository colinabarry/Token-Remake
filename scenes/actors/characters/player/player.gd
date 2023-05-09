class_name Player extends CharacterBody2D

var walk_speed := 100
var jump_velocity := 250
var gravity := 9.8

@onready var state_machine := $StateMachine as StateMachine
@onready var anim_player := $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	state_machine.init(self)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.input(event)


func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)


func _process(delta: float) -> void:
	state_machine.current_state.input_dir_x = (
		-Input.get_action_strength("move_left") + Input.get_action_strength("move_right")
	)
	velocity.x = state_machine.current_state.input_dir_x * walk_speed
	velocity.y += gravity

	state_machine.process(delta)
	move_and_slide()
