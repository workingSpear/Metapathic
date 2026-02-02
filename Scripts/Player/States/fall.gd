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

	parent_obj.move_and_slide()

	# Rotate the mesh towards the current velocity.
	var horizontal_velocity = Vector3(parent_obj.velocity.x, 0.0, parent_obj.velocity.z)
	if !horizontal_velocity.is_zero_approx():
		mesh_holder.look_at(parent_obj.position + horizontal_velocity)

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


func is_moving_towards_wall() -> bool:
	return true


func process_input(_event: InputEvent) -> String:
	if (_event.is_action_pressed("jump")):
		# Check for ledge to climb.
		wall_check_raycast_feet.target_position = move_component.get_last_input_move_direction().rotated(Vector3.UP, move_component.get_input_move_rotation())
		wall_check_raycast_feet.force_raycast_update()
		if wall_check_raycast_feet.is_colliding():
			print("hit!")
			if wall_check_raycast_feet.get_collision_normal().angle_to(Vector3.UP) > parent_obj.floor_max_angle:
				print("wall!")
				var position: Vector3 = wall_check_raycast_feet.get_collision_point()
				ledge_check_raycast.global_position.x = position.x
				ledge_check_raycast.global_position.y = parent_obj.global_position.y + move_data.ledge_climb_height_above_parent
				ledge_check_raycast.global_position.z = position.z
				ledge_check_raycast.force_raycast_update()
				if ledge_check_raycast.is_colliding():
					print("ledge!")
					# Add the height of the character model
					parent_obj.position = ledge_check_raycast.get_collision_point() + Vector3(0.0, move_data.ledge_climb_target_height, 0.0)
					return ""
		if parent_obj.is_on_wall_only():
			var WALL_JUMP_VERTICAL_VELOCITY: float = move_data.jump_vertical_velocity * 0.9
			var WALL_JUMP_NORMAL_MAGNITUDE: float = 50.0
			var wall_jump_vector: Vector3 = parent_obj.get_wall_normal() * WALL_JUMP_NORMAL_MAGNITUDE
			parent_obj.velocity.y = max(parent_obj.velocity.y, 0.0) + WALL_JUMP_VERTICAL_VELOCITY
			parent_obj.velocity += wall_jump_vector
	return ""
