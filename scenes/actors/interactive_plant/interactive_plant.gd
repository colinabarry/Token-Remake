@tool
extends Area2D

enum Sprite {
	ROCKS,
	ROUND_BUSH,
	NARROW_BUSH,
	SMALL_FLOWERS,
	LARGE_FLOWERS,
	GRASS_1,
	SMALL_BUSH,
	TREE_TRUNK_1,
	TREE_TRUNK_2,
	LEAVES_1,
	LEAVES_2,
	GRASS_2,
	LARGE_MUSHROOM,
	SMALL_MUSHROOMS,
	TREE_TRUNK_3
}

@export var sprite_index := Sprite.ROCKS:
	set(val):
		sprite_index = val
		_update()
@export var top_drop_width := 4.0

var valid_indices := [1, 2, 3, 4, 5, 6, 9, 10, 11, 12, 13]

@onready var sprite := $Sprite2D as Sprite2D
@onready var animation_player := $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	if (
		sprite_index == Sprite.ROCKS
		and get_tree().get_edited_scene_root().name != "InteractivePlant"
	):
		sprite_index = (valid_indices[randi_range(0, valid_indices.size() - 1)] as Sprite)
	_update()


func _update() -> void:
	if sprite:
		sprite.frame = sprite_index


func _on_body_entered(body: Node2D) -> void:
	var body_distance := body.global_position.x - global_position.x

	if abs(body_distance) <= top_drop_width:
		# top drop
		animation_player.play("wiggle_top")
		return
	if body_distance < -top_drop_width:
		# hit from left
		animation_player.play("wiggle_right")
	if body_distance > top_drop_width:
		# hit from right
		animation_player.play("wiggle_left")
