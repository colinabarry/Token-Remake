extends Node2D

@onready var current_level: PackedScene = preload("res://scenes/levels/level_01/level_01.tscn")

var player_has_control := true:
	set(val):
		player_has_control = val
	get:
		return player_has_control


func _ready() -> void:
	pass

# func _input(_event: InputEvent) -> void:
# if Input.is_action_just_pressed("level_reset"):
# _change_scene(current_level)

# func _change_scene(to_packed: PackedScene) -> void:
# var try_scene_change :=
# get_tree().change_scene_to_packed(to_packed)
# print_debug(try_scene_change)
# match try_scene_change:
# 	OK:
# 		return true
# 	_:
# 		return false
