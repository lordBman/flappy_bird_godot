extends Node2D

class_name Main

@onready var pipe_spawner: PipeSpawner = $PipeSpawner
@onready var bird: Bird = $Bird
@onready var ground: Ground = $Ground
@onready var fade: Fade = $Fade
@onready var ui: UI = $UI

@export var speed = -150

func _ready() -> void:
	bird.game_started.connect(on_game_start)
	pipe_spawner.bird_crashed.connect(stop_bird)
	pipe_spawner.point_scored.connect(update_score)
	ground.bird_crashed.connect(end_game)
	ui.restart.connect(restart)
	_start()
	
func _start() -> void:
	ground.set_speed(speed)
	pipe_spawner.set_speed(speed)
	
func update_score() -> void:
	ui.increase_points()

func on_game_start():
	pipe_spawner.start_spawning()
	
func stop_bird()->void:
	bird.kill()
	ground.stop()
	fade.play()
	
func end_game():
	bird.stop()
	ground.stop()
	pipe_spawner.stop()
	ui.on_game_over()
	if bird.is_alive:
		fade.play()
		
func restart() -> void:
	bird.reset()
	pipe_spawner.reset()
	_start()
