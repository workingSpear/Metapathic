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


## Returns a normalized Vector3 indicating the character's target move
## direction, or Vector3.ZERO if there is no input.
func get_input_move_direction() -> Vector3:
	return Vector3.ZERO


## Returns a float indicating the angle to rotate the character's movement.
func get_input_move_rotation() -> float:
	return 0.0


## Return a boolean indicating if the character wants to jump.
func get_input_jump_press() -> bool:
	return false


## Return a boolean indicating if the character is holding jump.
func get_input_jump_hold() -> bool:
	return false


## Returns a boolean indicating if the character wants to sprint.
func get_input_sprint_hold() -> bool:
	return false


func get_input_dive_press() -> bool:
	return false
