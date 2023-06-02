class_name IdleState extends BaseState


func _init() -> void:
	resource_name = "IdleState"


func enter() -> void:
	super()
	# player.velocity.x = 0


func physics_process(_delta: float) -> void:
	player.fall()
	player.move()
