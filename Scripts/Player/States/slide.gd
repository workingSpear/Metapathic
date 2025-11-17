class_name Slide
extends MoveState

static var state_name: String = "Slide"

@export var rotation_speed: float


func get_state_name() -> String:
	return state_name


func enter() -> void:
	super()

	# Get the horizontal move direction at the start of the slide.
	var init_direction: Vector3 = move_component.get_input_move_direction()
	init_direction = init_direction.rotated(Vector3.UP, move_component.get_input_move_rotation())
	# If the player is not moving, manually set the initial direction
	# as the local forward direction.
	if init_direction.is_zero_approx():
		init_direction = Vector3.FORWARD.rotated(Vector3.UP, move_component.get_input_move_rotation())
	init_direction.y = 0.0
	init_direction = init_direction.normalized()

	# Get the horizontal speed of the slide.
	# Has a minimum speed, plus the slide speed boost.
	var init_horizontal_velocity: Vector3 = parent_obj.velocity
	init_horizontal_velocity.y = 0.0
	var init_speed: float = init_horizontal_velocity.length()
	init_speed = maxf(move_data.slide_speed_min, init_speed)
	init_speed += move_data.slide_speed_boost

	parent_obj.velocity = init_direction * init_speed


func process_physics(delta: float) -> String:
	# Apply drag on the velocity.
	parent_obj.velocity *= move_data.slide_move_speed_decay

	# Get the horizontal move direction.
	var move_direction: Vector3 = move_component.get_input_move_direction()
	move_direction = move_direction.rotated(Vector3.UP, move_component.get_input_move_rotation())
	# If the player is not moving, manually set the initial direction
	# as the local forward direction.
	if move_direction.is_zero_approx():
		move_direction = Vector3.FORWARD.rotated(Vector3.UP, move_component.get_input_move_rotation())
	move_direction.y = parent_obj.velocity.y
	move_direction = move_direction.normalized() * parent_obj.velocity.length()

	# Rotate the current velocity towards the target direction.
	var angle_to: float = parent_obj.velocity.angle_to(move_direction)
	if not is_zero_approx(angle_to):
		parent_obj.velocity = parent_obj.velocity.slerp(
			move_direction,
			move_data.slide_slerp_rate,
		)

	parent_obj.velocity.y -= gravity * move_data.move_gravity_multiplier * delta
	parent_obj.move_and_slide()

	var target_rot: float = atan2(move_direction.x, move_direction.z) - parent_obj.rotation.y
	mesh_holder.rotation.y = lerp_angle(mesh_holder.rotation.y, target_rot, rotation_speed)

	if not move_component.get_input_slide_hold():
		if move_direction.is_zero_approx() and parent_obj.velocity.is_zero_approx():
			return Idle.state_name
		return Move.state_name

	if parent_obj.velocity.is_zero_approx():
		return Idle.state_name

	if parent_obj.velocity.length() < move_data.move_speed:
		return Move.state_name

	if !parent_obj.is_on_floor():
		return Fall.state_name

	if move_component.get_input_jump_press() and parent_obj.is_on_floor():
		var exit_speed: float = parent_obj.velocity.length() + move_data.slide_jump_speed_boost
		parent_obj.velocity = parent_obj.velocity.normalized() * exit_speed
		return Jump.state_name

	return ""


func get_move_speed() -> float:
	return move_data.move_speed_sprint if move_component.get_input_sprint_hold() else move_data.move_speed
