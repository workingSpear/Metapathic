class_name Player
extends CharacterBody3D


@onready
var movement_state_machine: Node = $MovementStateMachine
@onready
var player_move_component = $PlayerMovementComponent
@onready
var mesh_holder = $MeshHolder

func _ready() -> void:
	movement_state_machine.init(self, mesh_holder, player_move_component)

func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	movement_state_machine.process_physics(delta)

func _process(delta: float) -> void:
	movement_state_machine.process_frame(delta)
