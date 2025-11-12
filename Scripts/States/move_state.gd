class_name MoveState
extends Node
## A class that all MoveStates inherit from.
##
## MoveStates contain process frame/physics/input processes to control a parent
## CharacterBody3D via a MoveStateMachine.
##
## Each MoveState can have a state name and a corresponding get_state_name()
## method that can be used to target the state transition.
## Note that these do not need to be unique, but the MoveStateMachine will be
## unable to differentiate states with the same name.
##
## Each process method returns a String that tells the MoveStateMachine which
## state to transition to.
## If the String is empty, the MoveStateMachine will keep the current MoveState.
## Otherwise, the MoveStateMachine will attempt to transition to the target
## state, based on the state name and the MoveStateMachine's Name-Node
## Dictionary.

## The CharacterBody3D that this MoveState controls.
var parent_obj: CharacterBody3D
## The Node that holds the parent's mesh.
var mesh_holder: Node3D
## The MoveInputComponent that passes inputs to the MoveState.
var move_component: MoveInputComponent
## The MoveStateData that contains movement data.
var move_data: MoveStateData
## The project's default gravity strength.
var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")


## Returns the state's name.
## If not defined by a child class, returns an empty String.
func get_state_name() -> String:
	return ""


## Called when the MoveStateMachine first transitions to this state.
func enter() -> void:
	pass


## Called when the MoveStateMachine transitions out of this state.
func exit() -> void:
	pass


## Handles process frame for the parent object.
## If this method returns a nonempty String, the MoveStateMachine will attempt
## to transition to a MoveState with the corresponding name.
func process_frame(_delta: float) -> String:
	return ""


## Handles process physics for the parent object.
## If this method returns a nonempty String, the MoveStateMachine will attempt
## to transition to a MoveState with the corresponding name.
func process_physics(_delta: float) -> String:
	return ""


## Handles process input for the parent object.
## If this method returns a nonempty String, the MoveStateMachine will attempt
## to transition to a MoveState with the corresponding name.
func process_input(_event: InputEvent) -> String:
	return ""


func get_move_input() -> Vector3:
	return move_component.get_move_direction().normalized()


func get_move_rotation() -> float:
	return move_component.get_move_rotation()


func get_rotated_move_direction() -> Vector3:
	return get_move_input().rotated(Vector3.UP, get_move_rotation())


func get_jump() -> bool:
	return move_component.wants_jump()


func get_jump_hold() -> bool:
	return move_component.wants_jump_hold()


func get_sprint() -> bool:
	return move_component.wants_sprint()


func get_dive() -> bool:
	return move_component.wants_dive()
