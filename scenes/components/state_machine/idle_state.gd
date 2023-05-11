class_name IdleState extends BaseState


func _init() -> void:
	resource_name = "IdleState"


func enter() -> void:
	player.velocity.x = 0
