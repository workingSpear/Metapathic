class_name MoveStateMachine
extends Node

@export var starting_state: MoveState

var current_state: MoveState


## Initialize the state machine by giving each child state a reference to the
## parent object it belongs to and enter the default starting_state.
func init(parent: CharacterBody3D, mesh_holder: Node3D, move_component: MoveInputComponent, move_data: MoveStateData) -> void:
	for child: MoveState in get_children():
		child.parent_obj = parent
		child.mesh_holder = mesh_holder
		child.move_component = move_component
		child.move_data = move_data

	# Initialize to the default state
	change_state(starting_state)


## Change to the new state by first calling any exit logic on the current state.
func change_state(new_state: MoveState) -> void:
	if current_state:
		current_state.exit()
	print("Now entering: ", new_state.name)
	current_state = new_state
	current_state.enter()


## Pass through functions for the Player to call,
## handling state changes as needed.
func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)


func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)


func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
