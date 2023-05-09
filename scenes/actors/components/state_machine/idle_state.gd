extends BaseState


func enter() -> void:
	player.velocity.x = 0


func input(_event: InputEvent) -> int:
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		return State.WALK
	elif Input.is_action_just_pressed("move_jump"):
		return State.JUMP

	return State.NULL


func process(_delta: float) -> int:
	player.velocity.y += player.gravity

	if !player.is_on_floor():
		return State.FALL

	return State.NULL
