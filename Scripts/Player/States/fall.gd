class_name Fall
extends MoveState

static var state_name: String = "Fall"


func get_state_name() -> String:
	return state_name


func process_physics(delta: float) -> String:
	var move_direction: Vector3 = move_component.get_input_move_direction()
	move_direction = move_direction.rotated(Vector3.UP, move_component.get_input_move_rotation())

	var move_speed: float = get_move_speed()

	var target_move_velocity: Vector3 = move_direction * move_speed
	target_move_velocity.y = parent_obj.velocity.y

	parent_obj.velocity = parent_obj.velocity.move_toward(
		target_move_velocity,
		move_data.fall_move_acceleration * delta,
	)

	parent_obj.velocity.y -= gravity * move_data.fall_gravity_multiplier * delta
	# Wall jump
	if move_component.get_input_jump_press():
		if parent_obj.is_on_wall_only():
			var WALL_JUMP_VERTICAL_VELOCITY: float = move_data.jump_vertical_velocity * 0.9
			var WALL_JUMP_NORMAL_MAGNITUDE: float = 50.0
			var wall_jump_vector: Vector3 = parent_obj.get_wall_normal() * WALL_JUMP_NORMAL_MAGNITUDE
			parent_obj.velocity.y = max(parent_obj.velocity.y, 0.0) + WALL_JUMP_VERTICAL_VELOCITY
			parent_obj.velocity += wall_jump_vector

	parent_obj.move_and_slide()

	if parent_obj.is_on_floor():
		if move_component.get_input_slide_hold():
			return Slide.state_name
		if move_direction.is_zero_approx() and parent_obj.velocity.is_zero_approx():
			return Idle.state_name
		return Move.state_name

	if move_component.get_input_dive_press():
		return Dive.state_name

	return ""


func get_move_speed() -> float:
	return move_data.fall_move_speed_sprint if move_component.get_input_sprint_hold() else move_data.fall_move_speed
