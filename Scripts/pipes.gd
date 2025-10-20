extends Node2D

class_name Pipes

signal bird_collided
signal point_scored

var speed: int = -100

func set_speed(new_speed: int ):
	speed = new_speed
	
func _process(delta: float) -> void:
	position.x += speed * delta
	
func _on_body_entered(body: Node2D) -> void:
	bird_collided.emit()
	
func _on_point_scored(body: Node2D) -> void:
	point_scored.emit()
