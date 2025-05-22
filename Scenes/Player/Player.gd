extends CharacterBody2D

signal player_fired_bullet(bullet)

const SPEED = 2000.0

@onready var sprite = $Marker2D/Alive
@onready var pistol = $Marker2D/Pistol

func _ready() -> void:
	pistol.connect("weapon_fired", self.shoot)

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
	
func _unhandled_input(event):
	if Input.is_action_just_pressed("fire"):
		pistol.shoot()
	
func shoot(bullet_instance, _transform):
	emit_signal("player_fired_bullet", bullet_instance, _transform)
