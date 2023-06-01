class_name FallState extends BaseState


func _init() -> void:
	resource_name = "FallState"


# func enter() -> void:
# 	super()


func process(_delta: float) -> void:
	player.move()
	player.fall(12.0)
