extends Area2D

# controlled in animation
var can_activate := true:
	set(val):
		can_activate = val


func _on_body_entered(body: Node2D) -> void:
	if not can_activate:
		return

	if body.has_method("move_and_slide"):
		body.velocity.y = -325
		$AnimationPlayer.play("activate")
