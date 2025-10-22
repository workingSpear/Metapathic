extends MovementState


@export var fall_state: MovementState
@export var idle_state: MovementState
@export var move_state: MovementState

@export var jump_force: float = 20.0

var move_direction: Vector3
var cam_rotation : float
var move_resource = preload("res://Resources/Player States/move_state.tres")

func _enter() -> void:
	super()
	parent_obj.velocity.y = jump_force

func _process_physics(delta: float) -> MovementState:
	move_direction = get_movement_input()
	move_direction = move_direction.rotated(Vector3.UP, cam_rotation)
	move_direction = move_direction.normalized()

	var calculated_velocity: Vector3
	var move_speed = move_resource.move_speed
	if Input.is_action_pressed("sprint"):
		move_speed = move_resource.move_speed_sprint

	calculated_velocity.x = move_speed * move_direction.x
	calculated_velocity.y = parent_obj.velocity.y
	calculated_velocity.z = move_speed * move_direction.z

	parent_obj.velocity = parent_obj.velocity.move_toward(
		calculated_velocity,
		move_resource.acceleration * delta
	)

	parent_obj.velocity.y -= gravity * move_resource.gravity_jump_multiplier * delta
	parent_obj.move_and_slide()


	if parent_obj.is_on_floor():
		if move_direction != Vector3.ZERO:
			return move_state
		return idle_state

	if not Input.is_action_pressed("jump") or parent_obj.velocity.y < 0:
		return fall_state

	return null


func _on_camera_holder_set_cam_rotation(rotation: float) -> void:
	cam_rotation = rotation
