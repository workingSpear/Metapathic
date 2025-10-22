extends MoveState

@export var move_state: MoveState
@export var fall_state: MoveState
@export var jump_state: MoveState


func enter():
	super()
	parent_obj.velocity.x = 0
	parent_obj.velocity.z = 0


func process_input(_event: InputEvent) -> MoveState:
	if get_jump() and parent_obj.is_on_floor():
		return jump_state
	if not get_move_input().is_zero_approx():
		return move_state
	return null


func process_physics(delta: float) -> MoveState:
	## TODO: do movement things here
	parent_obj.velocity.y -= gravity * delta
	parent_obj.move_and_slide()

	if !parent_obj.is_on_floor():
		return fall_state
	return null
