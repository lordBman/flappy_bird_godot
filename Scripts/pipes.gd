extends Node2D

class_name Pipes

signal bird_collided
signal point_scored

var _current_speed: int = 0

func _ready() -> void:
	var viewport_rect = get_viewport_rect()
	position.x = viewport_rect.end.x
	
	var half_height = viewport_rect.size.y / 2
	position.y = randf_range(viewport_rect.size.y * 0.15 - half_height, viewport_rect.size.y * 0.65 - half_height)
	process_mode = Node.PROCESS_MODE_INHERIT

func set_speed(new_speed: int):
	_current_speed = new_speed

func _process(delta: float) -> void:
	position.x += _current_speed * delta
	
func _on_entered(_body: Node2D) -> void:
	bird_collided.emit()
	
func _on_point_scored(_body: Node2D) -> void:
	point_scored.emit()
	
func stop():
	_current_speed = 0

func _on_screen_exited() -> void:
	queue_free()
