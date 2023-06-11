# @tool
extends CanvasLayer

@export var palette: Array[Array]
@export var animation_player: AnimationPlayer
@export var player: Player
@export var level_layer: CanvasLayer
@export var blur_layer: CanvasLayer
@export var crt_layer: CanvasLayer
@export var levels: PackedStringArray

var current_level: Level
var next_level: Level

@onready var texture_rect := $PlayerLayer/Player/TextureRect as TextureRect


func _ready() -> void:
	player.died.connect(_on_player_died)

	if levels.size() == 0:
		return

	if ResourceLoader.exists(levels[1]):
		current_level = load(levels[1]).instantiate()

	level_layer.add_child(current_level)

	# texture writing test
	palette = Palette.calculate_palette()

	var palette_image := Image.create(8, 32, false, Image.FORMAT_RGB8)
	palette_image.fill(Color.WHITE)

	# print(palette)
	for color in range(32):
		# print("color: ", color)
		for shade in range(8):
			# print("\tshade: ", shade)
			palette_image.set_pixel(shade, color, palette[color][shade])
			# print(palette[color][shade])

	palette_image.save_png("assets/test.png")
	# var palette_texture := ImageTexture.create_from_image(palette_image)
	# texture_rect.texture = palette_texture
	texture_rect.texture = load("assets/test.png")


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("level_reset"):
		_change_scene(current_level.level_index)


func _change_scene(to_level_index: int) -> void:
	player.position = player.spawn_location
	player.velocity = Vector2.ZERO
	var new_level: Level = load(levels[to_level_index]).instantiate()
	current_level.call_deferred("queue_free")
	current_level = new_level
	level_layer.add_child(current_level)


func _on_player_died() -> void:
	_change_scene(current_level.level_index)
