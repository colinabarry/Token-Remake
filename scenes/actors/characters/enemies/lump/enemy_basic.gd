extends CharacterBody2D

enum DIR { RIGHT = 1, LEFT = -1 }

@export var animation_player: AnimationPlayer
@export var is_hopper := false
@export var patrol_width := 16.0
@export var patrol_speed := 10.0
@export var start_dir := DIR.RIGHT

var dir := start_dir
var is_alive := true

@onready var health := $HealthComponent as HealthComponent
@onready var damage := $DamageComponent as DamageComponent
@onready var hop_detector := $HopDetector as Area2D
@onready var collision := $EnemyCollision as CollisionShape2D

@onready var spawn_position := position


func _ready() -> void:
	dir = start_dir
	health.add_to_group("lump")

	if patrol_width > 0:
		animation_player.play("walk")


func _process(delta: float) -> void:
	# if is_hopper:
	velocity.y += 9.8
	move_and_slide()

	if not is_alive:
		velocity.x = 0
		return

	if patrol_width > 0:
		position.x = move_toward(
			position.x, spawn_position.x + patrol_width * dir, patrol_speed * delta
		)
		if abs(position.x - spawn_position.x) == patrol_width:
			dir *= -1


func die() -> void:
	if not is_alive:
		return

	is_alive = false
	set_collision_mask_value(5, false)
	damage.queue_free()
	health.queue_free()
	hop_detector.queue_free()
	animation_player.play("die")


func _hop() -> void:
	print_debug("hoppy")
	velocity.y = -250.0


func _on_hop_detector_body_entered(body: Node2D) -> void:
	if not is_alive:
		return

	var player := body as Player
	if not player:
		return

	_hop()
