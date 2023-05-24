class_name WalkState extends BaseState


func _init() -> void:
	resource_name = "WalkState"


func process(_delta: float) -> void:
	player.move()
	player.fall()
