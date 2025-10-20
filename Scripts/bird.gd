extends CharacterBody2D

class_name Bird

@export var gravity: float = 900.0
@export var jump_force: int = -300
@export var rotation_speed: int = 2

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var max_speed: int = 400
var is_started: bool = false
var process_input: bool = true

func _ready() -> void:
	velocity = Vector2.ZERO
	animation_player.play("idle")
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		if !is_started:
			is_started = true
		if process_input:
			animation_player.play("flap_wings")
			jump()
	
	if is_started:
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, max_speed)
		
		move_and_collide(velocity * delta)
		rotate_bird()
		
func jump():
	velocity.y = jump_force
	rotation = deg_to_rad(-30)

func rotate_bird():
	# Rotate downwrds when failing
	if velocity.y > 0 && rotation_degrees < 90:
		rotation_degrees += rotation_speed * 1
	elif velocity.y < 0 && rotation_degrees > -30:
		rotation_degrees -= rotation_speed * 1

func stop():
	animation_player.stop()
	gravity = 0
	velocity = Vector2.ZERO
	process_input = false
