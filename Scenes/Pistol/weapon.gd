extends Node2D

signal weapon_fired(bullet, _transform)

var damage: int = 50
var cooldown_secs: float = 0.65
var spread_angle: float = 1.5
var spray: Transform2D

@export var Bullet_Scene: PackedScene

@onready var pistol_sound = $pistol_sound
@onready var end_of_gun = $End_Of_Gun
@onready var weapon_cooldown = $weapon_cooldown

func _ready() -> void:
	weapon_cooldown.set_wait_time(cooldown_secs)

func shoot():
	if weapon_cooldown.is_stopped() and Bullet != null:
		var bullet = Bullet_Scene.instantiate()
		bullet.initialize(damage)
		spray = end_of_gun.global_transform
		var rand_spray = randf_range(-spread_angle/2, spread_angle/2)
		#get rotated idiot
		spray.x = spray.rotated(end_of_gun.rotation + deg_to_rad(rand_spray)).x
		spray.y = spray.rotated(end_of_gun.rotation + deg_to_rad(rand_spray)).y
		emit_signal("weapon_fired", bullet, spray)
		pistol_sound.play()
		weapon_cooldown.start()
