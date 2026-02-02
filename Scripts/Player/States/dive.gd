class_name Dive
extends MoveState

static var state_name: String = "Dive"

var timer: Timer
var gravity_multiplier: float


func _init() -> void:
	timer = Timer.new()
	timer.autostart = false
	timer.ignore_time_scale = false
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)


func get_state_name() -> String:
	return state_name


func enter() -> void:
	super()

	# Get the horizontal move direction at the start of the dive
	var init_direction = move_component.get_input_move_direction()
	init_direction = init_direction.rotated(Vector3.UP, move_component.get_input_move_rotation())
	# If the player is not moving, manually set the initial direction
	# as the local forward direction.
	if init_direction.is_zero_approx():
		init_direction = Vector3.FORWARD.rotated(Vector3.UP, move_component.get_input_move_rotation())
	init_direction.y = 0.0
	init_direction = init_direction.normalized()

	# Get the horizontal speed of the dive.
	# Has a minimum speed, plus the dive speed boost.
	var init_horizontal_velocity = parent_obj.velocity
	init_horizontal_velocity.y = 0.0
	var init_speed: float = init_horizontal_velocity.length()
	init_speed = maxf(move_data.dive_speed_min, init_speed)
	init_speed += move_data.dive_speed_boost

	parent_obj.velocity = init_direction * init_speed

	timer.start(move_data.dive_time)
	gravity_multiplier = move_data.dive_gravity_multiplier


func process_physics(delta: float) -> String:
	var move_direction = move_component.get_input_move_direction()
	move_direction = move_direction.rotated(Vector3.UP, move_component.get_input_move_rotation())

	var move_speed = get_move_speed()

	var target_move_velocity: Vector3 = move_direction * move_speed
	target_move_velocity.y = parent_obj.velocity.y

	parent_obj.velocity = parent_obj.velocity.move_toward(
		target_move_velocity,
		move_data.dive_move_acceleration * delta,
	)

	parent_obj.velocity.y -= gravity * gravity_multiplier * delta
	parent_obj.move_and_slide()

	# Rotate the mesh towards the current velocity.
	var horizontal_velocity = Vector3(parent_obj.velocity.x, 0.0, parent_obj.velocity.z)
	if !horizontal_velocity.is_zero_approx():
		mesh_holder.look_at(parent_obj.position + horizontal_velocity)

	# Jump input can lead to a ledge climb or wall jump.
	if move_component.get_input_jump_press():
		# Check for ledge to climb.
		if is_moving_toward_ledge():
			#print("ledge!")
			parent_obj.position = ledge_check_raycast.get_collision_point() + Vector3(0.0, move_data.ledge_climb_target_height, 0.0)
			parent_obj.velocity.y = 0.0
			# Transition into target state.
			if move_component.get_input_slide_hold():
				return Slide.state_name
			if move_direction.is_zero_approx() and parent_obj.velocity.is_zero_approx():
				return Idle.state_name
			return Move.state_name
		# Check for wall to wall jump from.
		elif parent_obj.is_on_wall_only():
			parent_obj.velocity.y = max(parent_obj.velocity.y, 0.0) + move_data.wall_jump_vertical_velocity
			parent_obj.velocity += parent_obj.get_wall_normal() * move_data.wall_jump_normal_velocity
			return Fall.state_name

	if parent_obj.is_on_floor():
		if move_component.get_input_slide_hold():
			return Slide.state_name
		if move_direction.is_zero_approx() and parent_obj.velocity.is_zero_approx():
			return Idle.state_name
		return Move.state_name

	return ""


func get_move_speed() -> float:
	return move_data.dive_move_speed_sprint if move_component.get_input_sprint_hold() else move_data.dive_move_speed


func is_moving_toward_wall() -> bool:
	wall_check_raycast_feet.target_position = move_component.get_last_input_move_direction().rotated(Vector3.UP, move_component.get_input_move_rotation())
	wall_check_raycast_feet.force_raycast_update()

	if !wall_check_raycast_feet.is_colliding():
		return false

	return wall_check_raycast_feet.get_collision_normal().angle_to(parent_obj.up_direction) > parent_obj.floor_max_angle


func is_moving_toward_ledge() -> bool:
	if !is_moving_toward_wall():
		return false

	var position: Vector3 = wall_check_raycast_feet.get_collision_point()
	ledge_check_raycast.global_position.x = position.x
	ledge_check_raycast.global_position.y = parent_obj.global_position.y + move_data.ledge_climb_height_above_parent
	ledge_check_raycast.global_position.z = position.z
	ledge_check_raycast.force_raycast_update()

	return ledge_check_raycast.is_colliding()


func _on_timer_timeout() -> void:
	gravity_multiplier = move_data.fall_gravity_multiplier
