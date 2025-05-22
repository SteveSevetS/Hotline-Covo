extends Node2D

signal weapon_fired(bullet, _transform)

@export var Bullet:PackedScene = load("res://Scenes/Player/bullet.tscn")
@export var damage = 50

@onready var pistol_sound = $pistol_sound
@onready var end_of_gun = $End_Of_Gun
@onready var weapon_cooldown = $weapon_cooldown

func shoot():
	if weapon_cooldown.is_stopped() and Bullet != null:
		var bullet = Bullet.instantiate()
		emit_signal("weapon_fired", bullet, end_of_gun.global_transform)
		pistol_sound.play()
		weapon_cooldown.start()
