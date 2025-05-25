extends CharacterBody2D

@export var Health_stat: Health
@onready var DeathAnimation = $Death_Animation

func _ready() -> void:
	Health_stat.initalize(100)

func handle_hit(_damage: int) -> void:
	Health_stat.decrease_health(_damage)
	if Health_stat.is_dead():
		died()

func died() -> void:
	DeathAnimation.play("Enemy_Death")
	
