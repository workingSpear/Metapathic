class_name Dive
extends MoveState

static var state_name: String = "Dive"

var timer: Timer
var gravity_multiplier: float


func get_state_name() -> String:
	return state_name


func _init() -> void:
	timer = Timer.new()
	timer.autostart = false
	timer.ignore_time_scale = false
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)


func enter() -> void:
	super()

	# Get the horizontal move direction at the start of the dive
	var init_direction: Vector3 = get_rotated_move_direction()
	# If the player is not moving, manually set the initial direction
	# as the local forward direction.
	if init_direction.is_zero_approx():
		init_direction = Vector3.FORWARD.rotated(Vector3.UP, get_move_rotation())
	init_direction.y = 0.0
	init_direction = init_direction.normalized()

	# Get the horizontal speed of the dive.
	# Has a minimum speed, plus the dive speed boost.
	var init_horizontal_velocity = parent_obj.velocity
	init_horizontal_velocity.y = 0.0
	var init_speed: float = init_horizontal_velocity.length()
	init_speed = maxf(move_data.dive_speed_min, init_speed)
	init_speed += move_data.dive_speed_boost

	parent_obj.velocity = init_direction * init_speed

	timer.start(move_data.dive_time)
	gravity_multiplier = move_data.gravity_dive_multiplier


func process_physics(delta: float) -> String:
	var move_direction = get_rotated_move_direction()

	var move_speed = get_move_speed()

	var target_move_velocity: Vector3 = move_direction * move_speed
	target_move_velocity.y = parent_obj.velocity.y

	parent_obj.velocity = parent_obj.velocity.move_toward(
		target_move_velocity,
		move_data.acceleration * delta,
	)

	parent_obj.velocity.y -= gravity * gravity_multiplier * delta
	parent_obj.move_and_slide()

	if parent_obj.is_on_floor():
		if move_direction.is_zero_approx() and parent_obj.velocity.is_zero_approx():
			return Idle.state_name
		return Move.state_name

	return ""


func _on_timer_timeout() -> void:
	gravity_multiplier = move_data.gravity_fall_multiplier
