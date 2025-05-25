extends Node2D

signal weapon_fired(bullet: Bullet, _transform: Transform2D)
signal ammo_decreased(amount: int)

@export var weapon_equipped: Weapon
@export var inv: Inventory
@export var Bullet_Scene: PackedScene

@onready var weapon_sprite = $Sprite2D
@onready var pistol_sound = $pistol_sound
@onready var end_of_gun = $End_Of_Gun
@onready var weapon_cooldown = $weapon_cooldown
@onready var reload_cooldown = $reload_cooldown
@onready var reload_status = $reload_status

func _ready() -> void:
	if weapon_equipped:
		equip_weapon(weapon_equipped)
		reload_status.visible = false

func _process(delta: float) -> void:
	if !reload_cooldown.is_stopped():
		reload_status.set_value(reload_cooldown.time_left)

func shoot():
	if weapon_cooldown.is_stopped() and Bullet != null and weapon_equipped.bullet_count > 0 and reload_cooldown.is_stopped():
		var bullet = Bullet_Scene.instantiate()
		bullet.initialize(weapon_equipped.damage)
		weapon_equipped.spray = end_of_gun.global_transform
		var rand_spray = randf_range(-weapon_equipped.spread_angle/2, weapon_equipped.spread_angle/2)
		#get rotated idiot
		weapon_equipped.spray.x = weapon_equipped.spray.rotated(end_of_gun.rotation + deg_to_rad(rand_spray)).x
		weapon_equipped.spray.y = weapon_equipped.spray.rotated(end_of_gun.rotation + deg_to_rad(rand_spray)).y
		emit_signal("weapon_fired", bullet, weapon_equipped.spray)
		pistol_sound.play()
		weapon_cooldown.start()
		decrease_ammo(weapon_equipped.bullets_per_shots)
		
func decrease_ammo(shots_fired: int) -> void:
	weapon_equipped.bullet_count = clamp(weapon_equipped.bullet_count - shots_fired, 0, weapon_equipped.mag_size)
	ammo_decreased.emit(weapon_equipped.bullet_count)
	
func reload() -> void:
	if reload_cooldown.is_stopped() and weapon_equipped.bullet_count < weapon_equipped.mag_size:
		reload_status.visible = true
		reload_cooldown.start()
		print("reloading")
		await reload_cooldown.timeout
		weapon_equipped.bullet_count = weapon_equipped.mag_size
		ammo_decreased.emit(weapon_equipped.bullet_count)
		reload_status.visible = false
		print("finished reloading")

func equip_weapon(new_weapon: Weapon) -> void:
	weapon_equipped = new_weapon
	weapon_sprite.texture = new_weapon.texture
	pistol_sound.stream = new_weapon.sound
	weapon_cooldown.set_wait_time(new_weapon.cooldown_secs)
	reload_cooldown.set_wait_time(new_weapon.cooldown_secs_reload)
	reload_status.max_value = new_weapon.cooldown_secs_reload
