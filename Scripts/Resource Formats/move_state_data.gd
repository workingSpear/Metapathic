class_name MoveStateData
extends Resource

@export_group("Idle State", "idle_")
@export var idle_gravity_multiplier: float
@export_group("Move State")
@export var move_speed: float
@export var move_speed_sprint: float
@export var move_acceleration: float
@export var move_gravity_multiplier: float
@export_group("Jump State", "jump_")
@export var jump_move_speed: float
@export var jump_move_speed_sprint: float
@export var jump_move_acceleration: float
@export var jump_vertical_velocity: float
@export var jump_gravity_multiplier: float
@export_group("Fall State", "fall_")
@export var fall_move_speed: float
@export var fall_move_speed_sprint: float
@export var fall_move_acceleration: float
@export var fall_gravity_multiplier: float
@export_group("Dive State", "dive_")
@export var dive_move_speed: float
@export var dive_move_speed_sprint: float
@export var dive_move_acceleration: float
@export var dive_gravity_multiplier: float
@export var dive_time: float
@export var dive_speed_min: float
@export var dive_speed_boost: float
@export_group("Slide State", "slide_")
@export var slide_move_speed_decay: float
@export var slide_gravity_multiplier: float
@export var slide_speed_min: float
@export var slide_speed_boost: float
@export var slide_jump_speed_boost: float
@export_range(0, 1, 0.01) var slide_slerp_rate: float
@export_group("Ledge Climb", "ledge_climb_")
## The vertical position that the ledge climb raycast starts from.
## Represents the max height the parent can ledge climb.
@export var ledge_climb_height_above_parent: float
## Needs to be tuned by the height of the parent model and height above parent.
@export_range(0.0, 10.0, 0.1, "or_greater") var ledge_climb_raycast_distance: float
## The height above the ledge which the parent snaps to.
## Needs to account for the height of the parent model.
@export var ledge_climb_target_height: float
