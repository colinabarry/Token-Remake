extends BaseState


func process(_delta: float) -> int:
	# var input_dir_x := (
	# 	-Input.get_action_strength("move_left") + Input.get_action_strength("move_right")
	# )
	# player.velocity.x = input_dir_x * player.walk_speed
	# player.velocity.y += player.gravity

	if player.is_on_floor() and input_dir_x == 0:
		return State.IDLE
	elif player.is_on_floor() and input_dir_x != 0:
		return State.WALK

	return State.NULL
