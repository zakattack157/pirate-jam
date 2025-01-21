class_name Player extends CharacterBody2D


@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.name == "HitBox":
		print_debug(area.get_parent().name)
