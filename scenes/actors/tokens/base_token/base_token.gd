class_name BaseToken extends Area2D

enum TokenType {
	BASE_TOKEN,
	JUMP_TOKEN,
}

var token_type := TokenType.BASE_TOKEN

@onready var animation_player := $AnimationPlayer


func _ready() -> void:
	add_to_group("token")
	area_entered.connect(_on_area_entered)


func _collect() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("token_collector"):
		_collect()
