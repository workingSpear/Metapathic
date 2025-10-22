extends Node

signal set_cam_rotation(cam_rotation: float)

@export var yaw_node : Node3D
@export var pitch_node : Node3D
@export var camera : Camera3D

@export var yaw_accel : float = 15
@export var pitch_accel : float = 15

@export var pitch_max : float = 30
@export var pitch_min : float = -70

var player_prefrences : Player_Prefrences = preload("res://Resources/player_prefrences.tres")

var yaw : float = 0
var pitch : float = 0

var yaw_sensitivity : float
var pitch_sensitivity : float

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	yaw_sensitivity = player_prefrences.yaw_sensitivity
	pitch_sensitivity = player_prefrences.pitch_sensitivity

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		yaw += -event.relative.x * yaw_sensitivity
		pitch += -event.relative.y * pitch_sensitivity

func _physics_process(delta: float) -> void:
	pitch = clamp(pitch, pitch_min, pitch_max)

	yaw_node.rotation_degrees.y = lerp(yaw_node.rotation_degrees.y, yaw, yaw_accel * delta)
	pitch_node.rotation_degrees.x = lerp(pitch_node.rotation_degrees.x, pitch, pitch_accel * delta)

	set_cam_rotation.emit(yaw_node.rotation.y)
