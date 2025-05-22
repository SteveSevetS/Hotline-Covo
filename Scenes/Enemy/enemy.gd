extends CharacterBody2D

@export var max_health = 100

@onready var Health_stat: Health = $Health
@onready var DeathAnimation = $Death_Animation

func _ready() -> void:
	Health_stat.initalize(max_health)

func handle_hit(_damage: int) -> void:
	Health_stat.decrease_health(_damage)
	if Health_stat.is_dead():
		died()

func died() -> void:
	print("enemy died")
	DeathAnimation.play("Enemy_Death")
	
