extends Node

class_name Fade

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play()->void:
	animation_player.play("fade")
