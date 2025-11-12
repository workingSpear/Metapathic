class_name MoveInputComponent
extends Node
## A class that all MoveInputComponents inherit from.
##
## This Node is used to pass inputs into a MoveState. Rather than hardcoding
## the way that each MoveState receives inputs (for example, the Player jumps
## by pressing the jump key), the MoveState just needs any MoveInputComponent
## to tell it what inputs to react to.
##
## As an example, the Player and enemies can have the same MoveStates that are
## controlled differently by a Player MoveInputComponent and an enemy
## MoveInputComponent. The Player might receive inputs from button inputs, while
## an enemy might receive inputs from pathfinding.


## Returns a Vector3 indicating the character's target move direction.
## Must be implemented by child classes.
func get_move_direction() -> Vector3:
	return Vector3.ZERO


## Returns a float indicating the angle to rotate the character's movement.
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


func wants_dive() -> bool:
	return false
