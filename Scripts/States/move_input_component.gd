class_name MoveInputComponent
extends Node


## Returns a Vector3 indicating the character's target move direction.
## Must be implemented by child classes.
func get_move_direction() -> Vector3:
	return Vector3.ZERO


## Returns a float indicating the angle to rotate the character's move.
## Must be implemented by child classes.
func get_move_rotation() -> float:
	return 0.0


## Return a boolean indicating if the character wants to jump.
## Must be implemented by child classes.
func wants_jump() -> bool:
	return false


## Return a boolean indicating if the character is holding jump.
## Must be implemented by child classes.
func wants_jump_hold() -> bool:
	return false


## Returns a boolean indicating if the character wants to sprint.
## Must be implemented by child classes.
func wants_sprint() -> bool:
	return false
