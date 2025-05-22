extends Node

@onready var player = $Player
@onready var hud = $HUD

# Called when the node enters the scene tree for the first time.
func _ready():
	#connecting the player's signal for shooting
	player.connect("player_fired_bullet", handle_bullet_spawned)
	player.weapon.connect("ammo_decreased", hud.update_ammo)
	hud.set_weapon_name(player.weapon.w_name)

func handle_bullet_spawned(bullet, _transform):
	bullet.transform = _transform
	add_child(bullet)
