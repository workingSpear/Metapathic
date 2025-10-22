class_name PlayerMoveComponent
extends Node


func get_movement_direction() -> Vector3:
	var movement_direction: Vector3
	movement_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	movement_direction.z = Input.get_action_strength("backward") - Input.get_action_strength("forward")
	return movement_direction


# Return a boolean indicating if the character wants to jump
func wants_jump() -> bool:
	return Input.is_action_just_pressed("jump")
