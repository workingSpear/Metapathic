extends Node3D

@export var max_health: float = 10

@onready var current_health: float = max_health

func take_damage(damage):
	current_health -= damage
	
	# update healthbar
	$"Healthbar Viewport/Healthbar".value = current_health / max_health
	
	if (current_health <= 0):
		current_health = 0
		die()

func die():
	return
