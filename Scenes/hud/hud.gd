extends CanvasLayer

@onready var Ammo_count_label: Label = $Control/Ammo_Count_Label
@onready var Weapon_name_label: Label = $Control/Weapon_Name_Label

func create_ammo(max_ammo: int) -> void:
	Ammo_count_label.text = str(max_ammo)
	
func update_ammo(ammo: int) -> void:
	Ammo_count_label.text = str(ammo)

func set_weapon_name(weapon_name: String) -> void:
	Weapon_name_label.text = weapon_name
