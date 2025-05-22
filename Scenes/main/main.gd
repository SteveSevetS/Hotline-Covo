extends Node

@onready var player = $Player
@onready var marker = $Player/Marker2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#connecting the player's signal for shooting
	player.connect("player_fired_bullet", handle_bullet_spawned)


func handle_bullet_spawned(bullet, _transform):
	bullet.transform = _transform
	add_child(bullet)
