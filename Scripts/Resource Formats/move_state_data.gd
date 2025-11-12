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
