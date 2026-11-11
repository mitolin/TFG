extends Node3D

@export var speed: float = 3.0
@export var route: Node3D

var points: Array[Vector3] = []
var target_index: int = 1


func _ready() -> void:
	if route == null:
		return

	for point in route.get_children():
		if point is Node3D:
			points.append(point.global_position)

	if not points.is_empty():
		global_position = points[0]


func _process(delta: float) -> void:
	if target_index >= points.size():
		return

	var target := points[target_index]

	global_position = global_position.move_toward(
		target, speed * delta
	)

	if global_position.distance_to(target) < 0.01:
		target_index += 1
