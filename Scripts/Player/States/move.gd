class_name Move
extends MoveState

static var state_name: String = "Move"

@export var mesh_rotation_speed: float


func get_state_name() -> String:
	return state_name


func process_physics(delta: float) -> String:
	var move_direction = move_component.get_input_move_direction()
	move_direction = move_direction.rotated(Vector3.UP, move_component.get_input_move_rotation())

	var move_speed = get_move_speed()

	var target_move_velocity: Vector3 = move_direction * move_speed
	target_move_velocity.y = parent_obj.velocity.y

	parent_obj.velocity = parent_obj.velocity.move_toward(
		target_move_velocity,
		move_data.move_acceleration * delta,
	)

	parent_obj.velocity.y -= gravity * move_data.move_gravity_multiplier * delta
	parent_obj.move_and_slide()

	var target_rot = atan2(move_direction.x, move_direction.z) - parent_obj.rotation.y
	mesh_holder.rotation.y = lerp_angle(mesh_holder.rotation.y, target_rot, mesh_rotation_speed)

	if move_direction.is_zero_approx() and parent_obj.velocity.is_zero_approx():
		return Idle.state_name

	if !parent_obj.is_on_floor():
		return Fall.state_name

	if move_component.get_input_jump_press() and parent_obj.is_on_floor():
		return Jump.state_name

	if move_component.get_input_slide_hold():
		return Slide.state_name

	return ""


func get_move_speed() -> float:
	return move_data.move_speed_sprint if move_component.get_input_sprint_hold() else move_data.move_speed
