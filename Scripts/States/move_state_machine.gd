## A Node that manages move states for a CharacterBody3D.
##
## MoveStateMachine is responsible for holding MoveState nodes, running the
## correct physics, input, and frame processes, and transitioning between
## MoveStates.
##
## To use MoveStateMachine, a parent Node must initialize it by injecting the
## necessary components. Then, the parent Characterbody3D can be controlled by
## calling the MoveStateMachine's process functions in the respective parent
## processes.
class_name MoveStateMachine
extends Node

@export var starting_state: MoveState

var current_state: MoveState
var state_dictionary: Dictionary


## Initialize the state machine by giving each child state a reference to the
## parent object it belongs to and enter the default starting_state.
func init(
		parent: CharacterBody3D,
		mesh_holder: Node3D,
		move_component: MoveInputComponent,
		move_data: MoveStateData,
) -> void:
	state_dictionary = { }

	for child: MoveState in get_children():
		# Add the reference to each MoveState node to the dictionary.
		var state_name: String = child.get_state_name()
		state_dictionary.set(state_name, child)
		# Inject components into each MoveState.
		child.parent_obj = parent
		child.mesh_holder = mesh_holder
		child.move_component = move_component
		child.move_data = move_data

	print(owner.name + ": MoveStateMachine initialized with MoveStates:")
	print(state_dictionary.keys())

	# Initialize to the default state.
	change_state(starting_state.name)


## Change to the new state by first calling any exit logic on the current state.
func change_state(new_state_name: String) -> void:
	var new_state: MoveState = state_dictionary.get(new_state_name)
	if new_state == null:
		print(owner.name + ": Trying to transition to state " + new_state_name + " but it does not exist.")
		return

	if current_state:
		current_state.exit()

	print(owner.name + ": Now entering: " + new_state_name)
	current_state = new_state
	current_state.enter()


## Pass through functions for the Player to call,
## handling state changes as needed.
func process_physics(delta: float) -> void:
	var new_state_name: String = current_state.process_physics(delta)
	if new_state_name.length() != 0:
		change_state(new_state_name)


func process_input(event: InputEvent) -> void:
	var new_state_name: String = current_state.process_input(event)
	if new_state_name.length() != 0:
		change_state(new_state_name)


func process_frame(delta: float) -> void:
	var new_state_name: String = current_state.process_frame(delta)
	if new_state_name.length() != 0:
		change_state(new_state_name)
