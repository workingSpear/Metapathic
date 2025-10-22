extends MoveState

@export var idle_state: MoveState
@export var move_state: MoveState


func process_physics(delta: float) -> MoveState:
	var move_direction = get_rotated_move_direction()

	var move_speed = get_move_speed()

	var target_move_velocity: Vector3 = move_direction * move_speed
	target_move_velocity.y = parent_obj.velocity.y

	parent_obj.velocity = parent_obj.velocity.move_toward(
		target_move_velocity,
		move_data.acceleration * delta,
	)

	parent_obj.velocity.y -= gravity * move_data.gravity_fall_multiplier * delta
	parent_obj.move_and_slide()

	if parent_obj.is_on_floor():
		if move_direction.is_zero_approx() and parent_obj.velocity.is_zero_approx():
			return idle_state
		return move_state

	return null
