class_name PlayerMoveInputComponent
extends MoveInputComponent

var camera_rotation: float


func get_move_direction() -> Vector3:
	var move_direction: Vector3
	move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_direction.z = Input.get_action_strength("backward") - Input.get_action_strength("forward")
	return move_direction


func get_move_rotation() -> float:
	return camera_rotation


## Return a boolean indicating if the character wants to jump
func wants_jump() -> bool:
	return Input.is_action_just_pressed("jump")


## Return a boolean indicating if the character wants to jump
func wants_jump_hold() -> bool:
	return Input.is_action_pressed("jump")


## Return a boolean indicating if the character wants to sprint
func wants_sprint() -> bool:
	return Input.is_action_pressed("sprint")


func wants_dive() -> bool:
	return Input.is_action_just_pressed("dive")


func _on_camera_holder_set_cam_rotation(rotation: float) -> void:
	camera_rotation = rotation
