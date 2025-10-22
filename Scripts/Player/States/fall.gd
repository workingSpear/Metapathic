extends MovementState

@export var idle_state: MovementState
@export var move_state: MovementState

var move_direction: Vector3
var cam_rotation : float
var move_resource = preload("res://Resources/Player States/move_state.tres")

func _process_physics(_delta: float) -> MovementState:
	move_direction = get_movement_input()
	move_direction = move_direction.rotated(Vector3.UP, cam_rotation)
	move_direction = move_direction.normalized()

	var calculated_velocity: Vector3
	var move_speed = move_resource.move_speed
	if Input.is_action_pressed("sprint"):
		move_speed = move_resource.move_speed_sprint

	calculated_velocity.x = move_speed * move_direction.x
	calculated_velocity.y = parent_obj.velocity.y
	calculated_velocity.z = move_speed * move_direction.z

	parent_obj.velocity = parent_obj.velocity.move_toward(
		calculated_velocity,
		move_resource.acceleration * _delta
	)

	parent_obj.velocity.y -= gravity * move_resource.gravity_fall_multiplier * _delta
	parent_obj.move_and_slide()

	if parent_obj.is_on_floor():
		if move_direction.is_zero_approx() and parent_obj.velocity.is_zero_approx():
			return idle_state
		return move_state
	return null


func _on_camera_holder_set_cam_rotation(rotation: float) -> void:
	cam_rotation = rotation
