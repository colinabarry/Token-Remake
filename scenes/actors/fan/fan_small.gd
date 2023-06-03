extends Area2D

var is_pushing := false
var characters: Dictionary

@onready var animation_player := $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	animation_player.play("on")


func _process(delta: float) -> void:
	if not is_pushing:
		return

	for key in characters.keys():
		characters[key].velocity.y -= 850 * delta
	# for character in characters:
	# 	character.velocity.y -= 900 * delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("move_and_slide"):
		characters[body.get_instance_id()] = body
	# player = body as Player
	# if not player:
	# 	return

	is_pushing = true


func _on_body_exited(body: Node2D) -> void:
	if not characters.has(body.get_instance_id()):
		return

	characters.erase(body.get_instance_id())
	# player = body as Player
	# if not player:
	# 	return
	if characters.size() == 0:
		is_pushing = false
