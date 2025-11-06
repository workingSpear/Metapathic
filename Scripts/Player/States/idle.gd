class_name Idle
extends MoveState

static var state_name: String = "Idle"


func get_state_name() -> String:
	return state_name


func enter():
	super()
	parent_obj.velocity.x = 0
	parent_obj.velocity.z = 0


func process_input(_event: InputEvent) -> String:
	if get_jump() and parent_obj.is_on_floor():
		return Jump.state_name
	if not get_move_input().is_zero_approx():
		return Move.state_name
	return ""


func process_physics(delta: float) -> String:
	## TODO: do movement things here
	parent_obj.velocity.y -= gravity * delta
	parent_obj.move_and_slide()

	if !parent_obj.is_on_floor():
		return Fall.state_name
	return ""
