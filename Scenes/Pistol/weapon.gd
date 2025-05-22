extends Node2D

signal weapon_fired(bullet: Bullet, _transform: Transform2D)
signal ammo_decreased(amount: int)

var w_name: String = "Desert Eagle"
var damage: int = 50
var mag_size: int = 7
var cooldown_secs: float = 0.65
var spread_angle: float = 1.5
var spray: Transform2D
var bullet_count: int
var bullets_per_shots: int = 1
var cooldown_secs_reload: float = 2.6

@export var Bullet_Scene: PackedScene

@onready var pistol_sound = $pistol_sound
@onready var end_of_gun = $End_Of_Gun
@onready var weapon_cooldown = $weapon_cooldown
@onready var reload_cooldown = $reload_cooldown

func _process(delta: float) -> void:
	emit_signal("ammo_decreased", bullet_count)

func _ready() -> void:
	weapon_cooldown.set_wait_time(cooldown_secs)
	reload_cooldown.set_wait_time(cooldown_secs_reload)
	reload_cooldown.set
	bullet_count = mag_size
	emit_signal("ammo_decreased", mag_size)

func shoot():
	if weapon_cooldown.is_stopped() and Bullet != null and bullet_count > 0 and reload_cooldown.is_stopped():
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
		decrease_ammo(bullets_per_shots)
		
func decrease_ammo(shots_fired: int) -> void:
	bullet_count = clamp(bullet_count - shots_fired, 0, mag_size)
	emit_signal("ammo_decreased", bullet_count)
