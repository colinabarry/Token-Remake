class_name LevelLimit extends Area2D

@export var top := true
@export var screen_height: int = ProjectSettings.get_setting("display/window/size/viewport_width")

var screen_margin := 16

@onready var collision := $CollisionShape2D as CollisionShape2D


func _ready() -> void:
	var offset_sign = -1 if top else 1
	collision.position.y = offset_sign * (screen_height + screen_margin)
