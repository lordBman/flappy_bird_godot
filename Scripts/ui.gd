extends CanvasLayer

class_name UI

@onready var points: Label = $MarginContainer/Points
@onready var game_over: VBoxContainer = $MarginContainer/GameOver

@export var score = 0

signal restart

func _ready() -> void:
	_start()

func _display_score() -> void:
	points.text = "%d" % score

func _start() -> void:
	game_over.visible = false
	score = 0
	_display_score()
	
func increase_points() -> void:
	score += 1
	_display_score()
	
func on_game_over() -> void:
	game_over.visible = true

func _on_button_pressed() -> void:
	_start()
	restart.emit()
