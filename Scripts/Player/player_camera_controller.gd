class_name PlayerCameraController
extends Node

signal set_cam_rotation(cam_rotation: float)

@export var pivot_node: Node3D
@export var camera: Camera3D
@export var yaw_accel: float = 15
@export var pitch_accel: float = 15
@export var pitch_max: float = 30
@export var pitch_min: float = -70

var player_preferences: PlayerPreferences = preload("res://Resources/player_preferences.tres")
var yaw: float = 0
var pitch: float = 0
var yaw_sensitivity: float
var pitch_sensitivity: float


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	yaw_sensitivity = player_preferences.yaw_sensitivity
	pitch_sensitivity = player_preferences.pitch_sensitivity


func _physics_process(_delta: float) -> void:
	pitch = clamp(pitch, pitch_min, pitch_max)

	#With smoothing
	#pivot_node.rotation_degrees.y = lerp(pivot_node.rotation_degrees.y, yaw, yaw_accel * delta)
	#pivot_node.rotation_degrees.x = lerp(pivot_node.rotation_degrees.x, pitch, pitch_accel * delta)

	pivot_node.rotation_degrees.y = yaw
	pivot_node.rotation_degrees.x = pitch

	set_cam_rotation.emit(pivot_node.rotation.y)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		yaw += -event.relative.x * yaw_sensitivity
		pitch += -event.relative.y * pitch_sensitivity
	if event.is_action_pressed("pause"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
