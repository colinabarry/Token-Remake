class_name HealthComponent extends Area2D

@export var base_health := 1

var health := base_health


func _take_damage(damage_component: DamageComponent) -> void:
	if damage_component.damage >= health:
		_die()


func _die() -> void:
	get_parent().die()


func _on_area_entered(area: Area2D) -> void:
	var damage_component = area as DamageComponent
	if damage_component:
		_take_damage(damage_component)
