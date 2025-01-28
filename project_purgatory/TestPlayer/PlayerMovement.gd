class_name Player extends CharacterBody2D

signal healthChanged
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

@export var speed = 400
var can_move: bool = true # True, player can move. False, player does not move
@export var max_health = 3
@onready var current_health: int = max_health


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

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy1"):
		current_health -= 1
		if current_health < 0:
			get_tree().reload_current_scene()
		healthChanged.emit(current_health)
