class_name JumpState extends BaseState


func _init() -> void:
	resource_name = "JumpState"


func enter() -> void:
	super()
	player.velocity.y -= player.jump_velocity
