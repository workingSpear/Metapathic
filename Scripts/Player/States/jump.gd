extends MoveState

@export var fall_state: MoveState
@export var idle_state: MoveState
@export var move_state: MoveState
@export var dive_state: MoveState
@export var jump_force: float = 20.0


func enter() -> void:
	super()
	parent_obj.velocity.y = jump_force


func process_physics(delta: float) -> MoveState:
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
			return move_state
		return idle_state

	if not get_jump_hold() or parent_obj.velocity.y < 0:
		return fall_state

	if get_dive():
		return dive_state

	return null
