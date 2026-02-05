class_name Player
extends CharacterBody3D

@export var player_move_data: MoveStateData = preload("res://Resources/Player States/move_state.tres")

# Player attack stuff for dummy enemy testing
@export var player_attack_damage: float = 1.0
@export var Enemy: RigidBody3D = null

@onready var move_state_machine: MoveStateMachine = $MoveStateMachine
@onready var mesh_holder = $MeshHolder
@onready var player_move_input_component: PlayerMoveInputComponent = $PlayerMoveInputComponent
@onready var camera_holder: PlayerCameraController = $PlayerCameraHolder
@onready var wall_check_raycast_feet: RayCast3D = $WallCheckRaycastFeet
@onready var ledge_check_raycast: RayCast3D = $LedgeCheckRaycast


func _ready() -> void:
	camera_holder.set_cam_rotation.connect(player_move_input_component._on_camera_holder_set_cam_rotation)
	ledge_check_raycast.target_position.y = -abs(player_move_data.ledge_climb_raycast_distance)
	move_state_machine.init(
		self,
		mesh_holder,
		player_move_input_component,
		player_move_data,
		wall_check_raycast_feet,
		ledge_check_raycast,
	)


func _process(delta: float) -> void:
	move_state_machine.process_frame(delta)
	
	# This is a sloppy implementation of a player attack for the purposes of testing the dummy enemy prototype using the Input Map in Project Settings
	# The attack detection should probably eventually be either moved into the move_state_machine states or there should be a seperate state machine to handle attacks
	if Input.is_action_just_pressed("Attack"):
		attack(player_attack_damage)


func _physics_process(delta: float) -> void:
	move_state_machine.process_physics(delta)

func _unhandled_input(event: InputEvent) -> void:
	move_state_machine.process_input(event)

func attack(damage: float) -> void:
	# Again this is a sloppy implementation to test the take_damage() function and should eventually be replaced
	print("Player attacked!")
	if Enemy != null:
		Enemy.take_damage(damage)
