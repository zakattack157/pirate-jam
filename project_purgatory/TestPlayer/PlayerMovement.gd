extends CharacterBody2D


@export var speed = 400
var can_move: bool = true # True, player can move. False, player does not move

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	if not can_move:
		return
	get_input()
	move_and_slide()
