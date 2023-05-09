extends BaseState


func input(_event: InputEvent) -> int:
	if Input.is_action_just_pressed("move_jump"):
		return State.JUMP

	return State.NULL


func process(_delta: float) -> int:
	# var input_dir_x := (
	# 	-Input.get_action_strength("move_left") + Input.get_action_strength("move_right")
	# )
	# player.velocity.x = input_dir_x * player.walk_speed
	# player.velocity.y += player.gravity

	if !player.is_on_floor():
		return State.FALL
	if input_dir_x == 0:
		return State.IDLE

	return State.NULL
