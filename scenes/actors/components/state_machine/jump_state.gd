extends BaseState


func enter() -> void:
	super()
	player.velocity.y -= player.jump_velocity


func process(_delta: float) -> int:
	if player.velocity.y >= 0:
		return State.FALL

	return State.NULL
