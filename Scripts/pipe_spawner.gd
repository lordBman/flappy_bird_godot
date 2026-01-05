extends Node2D

class_name PipeSpawner

var pipes_scene = preload("res://Scenes/pipes.tscn")

@export var pipe_speed = -150
signal bird_crashed
signal point_scored

@onready var spawn_timer: Timer = $SpawnTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.timeout.connect(spawn_pipe)

func start_spawning() ->void:
	spawn_timer.start()
	
func spawn_pipe() ->void:
	var pipes = pipes_scene.instantiate() as Pipes
	add_child(pipes) 
	
	pipes.bird_collided.connect(func (): bird_crashed.emit())
	pipes.point_scored.connect(func (): point_scored.emit())

func stop():
	spawn_timer.stop()
	for pipes in get_children().filter(func (init): return init is Pipes):
		(pipes as Pipes).stop()
