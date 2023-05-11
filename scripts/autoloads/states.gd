extends Node

@onready var IDLE_STATE := IdleState.new()
@onready var WALK_STATE := WalkState.new()
@onready var FALL_STATE := FallState.new()
@onready var JUMP_STATE := JumpState.new()
