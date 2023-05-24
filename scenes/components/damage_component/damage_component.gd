@icon("res://assets/icons/icon_damage_component.png")
class_name DamageComponent extends Area2D

@export var damage := 1


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(_area: Area2D) -> void:
	pass
