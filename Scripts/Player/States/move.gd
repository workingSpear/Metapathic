extends MoveState

@export var idle_state: MoveState
@export var jump_state: MoveState
@export var fall_state: MoveState
@export var rotation_speed: float


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

	var target_rot = atan2(move_direction.x, move_direction.z) - parent_obj.rotation.y
	mesh_holder.rotation.y = lerp_angle(mesh_holder.rotation.y, target_rot, rotation_speed)

	if move_direction.is_zero_approx() and parent_obj.velocity.is_zero_approx():
		return idle_state

	if !parent_obj.is_on_floor():
		return fall_state

	if get_jump() and parent_obj.is_on_floor():
		return jump_state

	return null
