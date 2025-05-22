extends Area2D
class_name Bullet

@export var speed = 3500
var weapon_damage = load("res://pistol.tscn").instantiate().damage

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("handle_hit") and body.has_method("handle_death"):
		body.handle_hit(weapon_damage)
		if !body.is_dead():
			queue_free()
	else:
		queue_free()
