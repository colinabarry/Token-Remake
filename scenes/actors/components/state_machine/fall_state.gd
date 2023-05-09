extends BaseState


func process(_delta: float) -> int:
	if player.is_on_floor() and input_dir_x == 0:
		return State.IDLE
	elif player.is_on_floor() and input_dir_x != 0:
		return State.WALK

	return State.NULL
