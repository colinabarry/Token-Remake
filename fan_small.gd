extends Area2D

var is_pushing := false
var player


func _process(delta: float) -> void:
	if not is_pushing:
		return

	player.velocity.y -= 900 * delta


func _on_body_entered(body: Node2D) -> void:
	player = body as Player
	if not player:
		return

	is_pushing = true


func _on_body_exited(body: Node2D) -> void:
	player = body as Player
	if not player:
		return

	is_pushing = false
