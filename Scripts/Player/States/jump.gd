class_name Jump
extends MoveState

static var state_name: String = "Jump"


func get_state_name() -> String:
	return state_name


func enter() -> void:
	super()
	parent_obj.velocity.y = move_data.jump_force


func process_physics(delta: float) -> String:
	var move_direction = get_rotated_move_direction()

	var move_speed = get_move_speed()

	var target_move_velocity: Vector3 = move_direction * move_speed
	target_move_velocity.y = parent_obj.velocity.y

	parent_obj.velocity = parent_obj.velocity.move_toward(
		target_move_velocity,
		move_data.acceleration * delta,
	)

	parent_obj.velocity.y -= gravity * move_data.gravity_jump_multiplier * delta
	parent_obj.move_and_slide()

	if parent_obj.is_on_floor():
		if move_direction != Vector3.ZERO:
			return Move.state_name
		return Idle.state_name

	if not get_jump_hold() or parent_obj.velocity.y < 0:
		return Fall.state_name

	if get_dive():
		return Dive.state_name

	return ""
