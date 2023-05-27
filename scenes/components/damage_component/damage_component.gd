@icon("res://assets/icons/icon_damage_component.png")
class_name DamageComponent extends Area2D

@export var damage := 1

@onready var parent := get_parent()


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if area is HealthComponent:
		if parent.has_method("stomp") and parent.is_in_group("player"):
			parent.stomp(area as HealthComponent)
