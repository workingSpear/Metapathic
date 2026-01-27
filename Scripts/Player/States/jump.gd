class_name Jump
extends MoveState

static var state_name: String = "Jump"


func get_state_name() -> String:
	return state_name


func enter() -> void:
	super()
	parent_obj.velocity.y = max(parent_obj.velocity.y, 0.0) + move_data.jump_vertical_velocity


func process_physics(delta: float) -> String:
	var move_direction = move_component.get_input_move_direction()
	move_direction = move_direction.rotated(Vector3.UP, move_component.get_input_move_rotation())

	var move_speed = get_move_speed()

	var target_move_velocity: Vector3 = move_direction * move_speed
	target_move_velocity.y = parent_obj.velocity.y

	parent_obj.velocity = parent_obj.velocity.move_toward(
		target_move_velocity,
		move_data.jump_move_acceleration * delta,
	)

	parent_obj.velocity.y -= gravity * move_data.jump_gravity_multiplier * delta
	parent_obj.move_and_slide()

	if parent_obj.is_on_floor():
		if move_component.get_input_slide_hold():
			return Slide.state_name
		if move_direction != Vector3.ZERO:
			return Move.state_name
		return Idle.state_name

	if not move_component.get_input_jump_hold() or parent_obj.velocity.y < 0:
		return Fall.state_name

	if move_component.get_input_dive_press():
		return Dive.state_name

	return ""


func get_move_speed() -> float:
	return move_data.jump_move_speed_sprint if move_component.get_input_sprint_hold() else move_data.jump_move_speed
