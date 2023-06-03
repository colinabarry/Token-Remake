class_name WalkState extends BaseState


func _init() -> void:
	resource_name = "WalkState"


func exit() -> void:
	player.anim_player.speed_scale = 1


func physics_process(_delta: float) -> void:
	player.move()
	player.fall()

	player.anim_player.speed_scale = remap(
		abs(player.velocity.x), 0, player.max_walk_speed, 0.25, 1
	)
