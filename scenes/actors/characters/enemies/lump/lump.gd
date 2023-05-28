extends Sprite2D

enum DIR { RIGHT = 1, LEFT = -1 }

@export var animation_player: AnimationPlayer
@export var patrol_width := 16.0
@export var patrol_speed := 10.0
@export var start_dir := DIR.RIGHT

var dir := start_dir
var is_alive := true

@onready var health := $HealthComponent as HealthComponent
@onready var damage := $DamageComponent as DamageComponent

@onready var spawn_position := position


func _ready() -> void:
	dir = start_dir
	health.add_to_group("lump")

	if patrol_width > 0:
		animation_player.play("walk")
	# else:
	# 	animation_player.play("RESET")


func _process(delta: float) -> void:
	if is_alive:
		if patrol_width > 0:
			position.x = move_toward(
				position.x, spawn_position.x + patrol_width * dir, patrol_speed * delta
			)
			if abs(position.x - spawn_position.x) == patrol_width:
				dir *= -1


func die() -> void:
	if is_alive:
		is_alive = false
		damage.queue_free()
		health.queue_free()
		animation_player.play("die")
