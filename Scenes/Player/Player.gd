extends CharacterBody2D

signal player_fired_bullet(bullet)
signal player_reload()

const SPEED = 2000.0

@export var inventory: Inventory

@onready var sprite = $Alive
@onready var weapon = $Weapon
@onready var hud = $HUD

func _ready() -> void:
	weapon.weapon_equipped = inventory.slots[0]
	weapon._ready()
	weapon.connect("weapon_fired", self.shoot)
	weapon.connect("ammo_decreased", hud.update_ammo)
	player_reload.connect(weapon.reload)
	hud.set_weapon_name(weapon.weapon_equipped.w_name)
	weapon.ammo_decreased.emit(weapon.weapon_equipped.mag_size)

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("fire"):
		weapon.shoot()
		
	if Input.is_action_just_pressed("reload"):
		player_reload.emit()
		
	if Input.is_action_just_pressed("inv_slot_1"):
		weapon.equip_weapon(inventory.slots[0])
		hud.set_weapon_name(weapon.weapon_equipped.w_name)
		weapon.ammo_decreased.emit(weapon.weapon_equipped.bullet_count)
	
	if Input.is_action_just_pressed("inv_slot_2"):
		weapon.equip_weapon(inventory.slots[1])
		hud.set_weapon_name(weapon.weapon_equipped.w_name)
		weapon.ammo_decreased.emit(weapon.weapon_equipped.bullet_count)
		
	if Input.is_action_just_pressed("inv_slot_3"):
		weapon.equip_weapon(inventory.slots[2])
		hud.set_weapon_name(weapon.weapon_equipped.w_name)
		weapon.ammo_decreased.emit(weapon.weapon_equipped.bullet_count)

func shoot(bullet_instance, _transform):
	emit_signal("player_fired_bullet", bullet_instance, _transform)
