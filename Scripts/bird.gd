extends CharacterBody2D

class_name Bird

@export var gravity: float = 900.0
@export var jump_force: int = -300
@export var rotation_speed: int = 2

signal game_started

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var max_speed: int = 400
var is_started: bool = false 
var is_alive: bool = true
var _current_gravity: float = 0.0

func _start() -> void:
	velocity = Vector2.ZERO
	is_alive = true
	_current_gravity = gravity
	position.y = 0
	rotation_degrees = 0

func _ready() -> void:
	_start()
	animation_player.play("idle")
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		if !is_started:
			is_started = true
			game_started.emit()
		jump()
	
	if is_started:
		velocity.y += _current_gravity * delta
		velocity.y = min(velocity.y, max_speed)
		
		move_and_collide(velocity * delta)
		rotate_bird()
		
func jump():
	if is_alive:
		animation_player.play("flap_wings")
		velocity.y = jump_force
		rotation = deg_to_rad(-30)

func rotate_bird():
	# Rotate downwrds when failing
	if velocity.y > 0 && rotation_degrees < 90:
		rotation_degrees += rotation_speed * 1
	elif velocity.y < 0 && rotation_degrees > -30:
		rotation_degrees -= rotation_speed * 1

func kill():
	is_alive = false
	
func stop():
	animation_player.stop()
	_current_gravity = 0
	velocity = Vector2.ZERO
	is_alive = false
	
func reset():
	_start()
