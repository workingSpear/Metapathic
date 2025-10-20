class_name MovementState
extends Node

var move_component

var gravity : int = ProjectSettings.get_setting("physics/3d/default_gravity")

var parent_obj : CharacterBody3D
var mesh_holder : Node3D

func _enter() -> void:
	pass

func _exit() -> void:
	pass

func _process_input(_event: InputEvent) -> MovementState:
	return null

func _process_frame(_delta: float) -> MovementState:
	return null

func _process_physics(_delta: float) -> MovementState:
	return null

func get_movement_input() -> Vector3:
	return move_component.get_movement_direction()

func get_jump() -> bool:
	return move_component.wants_jump()
