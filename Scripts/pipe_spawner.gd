extends Node2D

class_name PipeSpawner

var pipes_scene = preload("res://Scenes/pipes.tscn")

@export var pipe_speed = -150

@onready var spawn_timer: Timer = $SpawnTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.timeout.connect(spawn_pipe)

func start_spawning() ->void:
	spawn_timer.start()
	
func spawn_pipe() ->void:
	print("spawing pipes")
	var pipes = pipes_scene.instantiate() as Pipes
	add_child(pipes)
	
	var viewport_rect = get_viewport_rect()
	pipes.position.x = viewport_rect.end.x
