extends Node2D

class_name Health

var max_health: int
var health: int

func initalize(_health: int) -> void:
	max_health = _health
	health = _health

func decrease_health(damage: int) -> void:
	health = clamp(health - damage, 0, max_health)
	print(str(damage) + ":" + str(health))

func is_dead() -> bool:
	if health > 0:
		return false
	else:
		return true
