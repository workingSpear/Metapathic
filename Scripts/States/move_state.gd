class_name MoveState
extends Node

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")
var parent_obj: CharacterBody3D
var mesh_holder: Node3D
var move_component: MoveInputComponent
var move_data: MoveStateData


func enter() -> void:
	pass


func exit() -> void:
	pass


func process_input(_event: InputEvent) -> String:
	return ""


func process_frame(_delta: float) -> String:
	return ""


func process_physics(_delta: float) -> String:
	return ""


func get_move_input() -> Vector3:
	return move_component.get_move_direction().normalized()


func get_move_rotation() -> float:
	return move_component.get_move_rotation()


func get_rotated_move_direction() -> Vector3:
	return get_move_input().rotated(Vector3.UP, get_move_rotation())


func get_move_speed() -> float:
	return move_data.move_speed_sprint if get_sprint() else move_data.move_speed


func get_jump() -> bool:
	return move_component.wants_jump()


func get_jump_hold() -> bool:
	return move_component.wants_jump_hold()


func get_sprint() -> bool:
	return move_component.wants_sprint()


func get_dive() -> bool:
	return move_component.wants_dive()
