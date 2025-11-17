class_name PlayerMoveInputComponent
extends MoveInputComponent

var camera_rotation: float


func get_input_move_direction() -> Vector3:
	var move_direction: Vector3
	move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_direction.z = Input.get_action_strength("backward") - Input.get_action_strength("forward")
	return move_direction


func get_input_move_rotation() -> float:
	return camera_rotation


## Return a boolean indicating if the character wants to jump
func get_input_jump_press() -> bool:
	return Input.is_action_just_pressed("jump")


## Return a boolean indicating if the character wants to jump
func get_input_jump_hold() -> bool:
	return Input.is_action_pressed("jump")


## Return a boolean indicating if the character wants to sprint
func get_input_sprint_hold() -> bool:
	return Input.is_action_pressed("sprint")


func get_input_dive_press() -> bool:
	return Input.is_action_just_pressed("dive")


func get_input_slide_hold() -> bool:
	return Input.is_action_pressed("slide")


func _on_camera_holder_set_cam_rotation(rotation: float) -> void:
	camera_rotation = rotation
