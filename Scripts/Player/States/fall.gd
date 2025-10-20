extends MovementState

@export var idle_state: MovementState
@export var move_state: MovementState

func _process_physics(_delta: float) -> MovementState:
	parent_obj.velocity.y += -gravity * _delta
	parent_obj.move_and_slide()

	var move_direction = get_movement_input() 
	
	if parent_obj.is_on_floor():
		if move_direction != Vector3.ZERO:
			return move_state
		return idle_state
	return null
