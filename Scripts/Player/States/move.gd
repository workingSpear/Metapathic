extends MovementState


@export var idle_state: MovementState
@export var jump_state: MovementState
@export var fall_state: MovementState

@export var rotation_speed : float

var move_direction: Vector3

var move_resource = preload("res://Resources/Player States/move_state.tres")


func _process_physics(_delta: float) -> MovementState:
	if get_jump() and parent_obj.is_on_floor():
		return jump_state
	
	var calculated_velocity: Vector3
	
	calculated_velocity.x = move_resource.move_speed * move_direction.normalized().x
	calculated_velocity.z = move_resource.move_speed * move_direction.normalized().z
	
	parent_obj.velocity = parent_obj.velocity.lerp(calculated_velocity, move_resource.acceleration * _delta)	
	if(abs(parent_obj.velocity.length() - calculated_velocity.length()) < 1):
		parent_obj.velocity = calculated_velocity
	parent_obj.move_and_slide()
	
	var target_rot = atan2(move_direction.x, move_direction.z) - parent_obj.rotation.y
	mesh_holder.rotation.y = lerp_angle(mesh_holder.rotation.y, target_rot, rotation_speed)
	
	if parent_obj.velocity == Vector3.ZERO:
		return idle_state
	
	if !parent_obj.is_on_floor():
		return fall_state
	return null	

func _on_camera_holder_set_cam_rotation(cam_rotation: float) -> void:
	move_direction = get_movement_input().rotated(Vector3.UP, cam_rotation)
