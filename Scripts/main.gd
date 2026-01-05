extends Node2D

class_name Main

@onready var pipe_spawner: PipeSpawner = $PipeSpawner
@onready var bird: Bird = $Bird
@onready var ground: Ground = $Ground

var score = 0

func _ready() -> void:
	bird.game_started.connect(on_game_start)
	pipe_spawner.bird_crashed.connect(end_game)
	pipe_spawner.point_scored.connect(func (): score += 1)
	ground.bird_crashed.connect(stop_bird)

func on_game_start():
	pipe_spawner.start_spawning()

func stop_bird():
	bird.stop()
	end_game()
	
func end_game():
	bird.kill()
	ground.stop()
	pipe_spawner.stop()
