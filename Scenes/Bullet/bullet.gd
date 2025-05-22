extends Area2D

class_name Bullet

@export var speed: int = 3500
var damage: int

func initialize(_damage: int) -> void:
	damage = _damage

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.handle_hit(damage)
		print("got damage")
	queue_free()
