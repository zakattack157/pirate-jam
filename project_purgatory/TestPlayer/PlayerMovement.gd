class_name Player extends CharacterBody2D

signal healthChanged
@export var speed = 400

@export var max_health = 3
@onready var current_health: int = max_health

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy1"):
		current_health -= 1
		if current_health < 0:
			current_health = max_health
		healthChanged.emit(current_health)
