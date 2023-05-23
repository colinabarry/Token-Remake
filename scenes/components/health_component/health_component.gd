@icon("res://assets/icons/icon_health_component.png")
class_name HealthComponent extends Area2D

@export var base_health := 1

var health := base_health


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _take_damage(damage_component: DamageComponent) -> void:
	if damage_component.damage >= health:
		_die()


func _die() -> void:
	get_parent().die()


func _on_area_entered(area: Area2D) -> void:
	var damage_component = area as DamageComponent
	if damage_component:
		_take_damage(damage_component)
