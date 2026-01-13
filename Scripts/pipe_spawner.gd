extends Node2D

class_name PipeSpawner

var pipes_scene = preload("res://Scenes/pipes.tscn")

signal bird_crashed
signal point_scored

@onready var spawn_timer: Timer = $SpawnTimer

var _current_speed: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.timeout.connect(spawn_pipe)

func start_spawning() ->void:
	spawn_timer.start()
	
func spawn_pipe() ->void:
	var pipes = pipes_scene.instantiate() as Pipes
	pipes.set_speed(_current_speed)
	add_child(pipes)
	
	pipes.bird_collided.connect(func (): on_bird_entered())
	pipes.point_scored.connect(func (): point_scored.emit())

func stop():
	spawn_timer.stop()
	for pipes in get_children().filter(func (init): return init is Pipes):
		(pipes as Pipes).stop()
		
func on_bird_entered()->void:
	bird_crashed.emit()
	stop()
	
func reset() -> void:
	for pipes in get_children().filter(func (init): return init is Pipes):
		(pipes as Pipes).queue_free()
	spawn_timer.start()
	
func set_speed(new_speed: int):
	_current_speed = new_speed
	for pipes in get_children().filter(func (init): return init is Pipes):
		(pipes as Pipes).set_speed(_current_speed)
