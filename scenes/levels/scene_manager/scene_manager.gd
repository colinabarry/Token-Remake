extends CanvasLayer

@export var animation_player: AnimationPlayer
@export var player: Player
@export var level_layer: CanvasLayer
@export var blur_layer: CanvasLayer
@export var crt_layer: CanvasLayer
@export var levels: PackedStringArray

var current_level: Level
var next_level: Level


func _ready() -> void:
	if levels.size() == 0:
		return

	if ResourceLoader.exists(levels[1]):
		current_level = load(levels[1]).instantiate()

	level_layer.add_child(current_level)
