extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

@export var speed = 400
var can_move: bool = true # True, player can move. False, player does not move

func _ready():
	anim.play("Idle")

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	match input_direction:
		Vector2(-1,0):
			anim.play("Walk_Left")
		Vector2(1,0):
			anim.play("Walk_Right")
		Vector2(0,-1):
			anim.play("Walk_Up")
		Vector2(0,1):
			anim.play("Idle")
		Vector2(0,0):
			anim.play("Idle")
	
	velocity = input_direction * speed

func _physics_process(delta):
	if not can_move:
		return
	get_input()
	move_and_slide()
