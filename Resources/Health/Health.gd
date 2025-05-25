extends Resource

class_name Health

@export var max_health: int
@export var health: int

func initalize(_health: int) -> void:
	max_health = _health
	health = _health

func decrease_health(damage: int) -> void:
	health = clamp(health - damage, 0, max_health)

func is_dead() -> bool:
	if health > 0:
		return false
	else:
		return true
