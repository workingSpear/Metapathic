class_name Enemy
extends RigidBody3D

# A basic dummy enemy base class which can take damage and die.

@export var max_health: float = 10

@onready var current_health: float = max_health

func _ready() -> void:
	pass

func take_damage(damage) -> void:
	current_health -= damage
	
	# update healthbar value
	$"Healthbar Viewport/Healthbar".value = current_health / max_health
	
	if (current_health <= 0):
		current_health = 0
		die()

func die() -> void:
	pass
