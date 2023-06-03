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
	player.died.connect(_on_player_died)

	if levels.size() == 0:
		return

	if ResourceLoader.exists(levels[1]):
		current_level = load(levels[1]).instantiate()

	level_layer.add_child(current_level)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("level_reset"):
		_change_scene(current_level.level_index)


func _change_scene(to_level_index: int) -> void:
	player.position = player.spawn_location
	player.velocity = Vector2.ZERO
	var new_level: Level = load(levels[to_level_index]).instantiate()
	current_level.queue_free()
	current_level = new_level
	level_layer.add_child(current_level)


func _on_player_died() -> void:
	_change_scene(current_level.level_index)
