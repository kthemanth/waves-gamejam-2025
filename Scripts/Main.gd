extends Node2D


@onready var camera: Camera2D = $Camera2D
@onready var button: Button = $CanvasLayer/EndTurnButton

var card_scene = preload("res://UI/Card.tscn")

const CAMERA_SPEED := 400.0
const ZOOM_STEP := 0.2
const ZOOM_IN_LIMIT := Vector2(0.4, 0.4)
const ZOOM_OUT_LIMIT := Vector2(1.0, 1.0)

var zoom_tween


func _ready():
	pass


func _process(delta):
	handle_camera_vertical_movement(delta)
	handle_camera_zoom()


#--------------------------- CAMERA STUFF (should probably put it somewhere else) ------------------------------
func handle_camera_vertical_movement(delta: float) -> void:
	var move_dir := 0.0
	
	if camera.position.y > -370:
		if Input.is_action_pressed("move_up"):
			move_dir -= 1.0
	if camera.position.y < 270:
		if Input.is_action_pressed("move_down"):
			move_dir += 1.0

	if move_dir != 0.0:
		camera.position.y += move_dir * CAMERA_SPEED * delta

func handle_camera_zoom() -> void:
	if zoom_tween and zoom_tween.is_running():
		return

	if Input.is_action_just_pressed("zoom_in"):
		var target_zoom := camera.zoom + Vector2(ZOOM_STEP, ZOOM_STEP)
		target_zoom = target_zoom.clamp(ZOOM_IN_LIMIT, ZOOM_OUT_LIMIT)
		start_zoom_tween(target_zoom)

	elif Input.is_action_just_pressed("zoom_out"):
		var target_zoom := camera.zoom - Vector2(ZOOM_STEP, ZOOM_STEP)
		target_zoom = target_zoom.clamp(ZOOM_IN_LIMIT, ZOOM_OUT_LIMIT)
		start_zoom_tween(target_zoom)

func start_zoom_tween(target_zoom: Vector2) -> void:
	zoom_tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	zoom_tween.tween_property(camera, "zoom", target_zoom, 0.25)
# -------------------------- END OF CAMERA STUFF ---------------------------------------------------------------
