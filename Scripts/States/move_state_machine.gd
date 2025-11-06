class_name MoveStateMachine
extends Node
## A Node that manages move states for a CharacterBody3D.
##
## MoveStateMachine is responsible for holding MoveState nodes, running the
## correct physics, input, and frame processes, and transitioning between
## MoveStates.
##
## MoveStateMachine must be initialized by a parent, which injects the
## necessary components: a CharacterBody3D to move, a Node3D that holds the
## mesh, a MoveInputComponent that passes inputs to the MoveStates, and a
## MoveStateData resource that holds movement stats.
##
## The Characterbody3D can be controlled by calling the MoveStateMachine's
## process functions in the respective parent processes.

## The starting MoveState. If not assigned in the inspector, this defaults to
## the first child MoveState on the MoveStateMachine.
@export var starting_state: MoveState

## The current MoveState.
var current_state: MoveState
## A Dictionary that maps MoveState names to the corresponding MoveState node.
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
	# If the starting state is null, assign it to the first child MoveState.
	if starting_state == null:
		starting_state = get_child(0)
	change_state(starting_state.name)


## Add a MoveState component to the MoveStateMachine.
## Updates the state dictionary with the reference to the new MoveState.
## Use this method to dynamically add or set MoveStates, for example when the
## Player wants to add a new movement ability.
func add_move_state(state_node: MoveState) -> void:
	add_child(state_node)
	state_dictionary.set(state_node.get_state_name(), state_node)
	print(owner.name + ": Adding MoveState " + state_node.get_state_name() + ":")
	print(state_dictionary.keys())


## Removes a MoveState from the MoveStateMachine via its name.
## Removes the MoveState from the state dictionary.
## Frees the corresponding MoveState node.
## Use this method to dynamically remove MoveStates, for example when the
## Player wants to remove a movement ability.
func remove_move_state(state_name: String) -> void:
	var state: MoveState = state_dictionary.get(state_name)
	if state != null:
		state.queue_free()

	state_dictionary.erase(state_name)


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


## Calls the current state's process physics method.
## If the process method returns a valid state, transitions to the new state.
func process_physics(delta: float) -> void:
	var new_state_name: String = current_state.process_physics(delta)
	if new_state_name.length() != 0:
		change_state(new_state_name)


## Calls the current state's process input method.
## If the process method returns a valid state, transitions to the new state.
func process_input(event: InputEvent) -> void:
	var new_state_name: String = current_state.process_input(event)
	if new_state_name.length() != 0:
		change_state(new_state_name)


## Calls the current state's process frame method.
## If the process method returns a valid state, transitions to the new state.
func process_frame(delta: float) -> void:
	var new_state_name: String = current_state.process_frame(delta)
	if new_state_name.length() != 0:
		change_state(new_state_name)
