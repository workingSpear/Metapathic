extends MovementState

@export var move_state: MovementState
@export var jump_state: MovementState
@export var fall_state: MovementState


func _enter():
	super()
	parent_obj.velocity.x = 0
	parent_obj.velocity.z = 0


func _process_input(_event: InputEvent) -> MovementState:
	if get_jump() and parent_obj.is_on_floor():
		return jump_state
	if get_movement_input() != Vector3.ZERO:
		return move_state
	return null


func _process_physics(_delta: float) -> MovementState:
	## TODO: do movement things here
	parent_obj.velocity.y -= gravity * _delta
	parent_obj.move_and_slide()
	if !parent_obj.is_on_floor():
		return fall_state
	return null
