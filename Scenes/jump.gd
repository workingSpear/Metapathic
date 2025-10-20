extends MovementState


@export var fall_state: MovementState
@export var idle_state: MovementState
@export var move_state: MovementState

@export
var jump_force: float = 900.0

func _enter() -> void:
	super()
	parent_obj.velocity.y = -jump_force

func _process_physics(delta: float) -> MovementState:
	parent_obj.velocity.y += gravity * delta
	
	if parent_obj.velocity.y > 0:
		return fall_state
	
	var move_direction = get_movement_input()
	
	
	if parent_obj.is_on_floor():
		if move_direction != Vector3.ZERO:
			return move_state
		return idle_state
	
	return null
