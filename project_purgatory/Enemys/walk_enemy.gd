class_name WalkEnemy extends CharacterBody2D
#make these like a small flying little guy
@export var speed = 40
@export var limit = 0.5
@export var health = 3

var target: Player
var start_position
var end_position

func _ready():
	start_position = position
	end_position = start_position - Vector2(0, 3*32)
func change_direction():
	var temp_end = end_position
	end_position = start_position
	start_position = temp_end
	
func update_velocity():
	var move_direction = end_position - position
	if move_direction.length() < limit:
		change_direction()
	velocity = move_direction.normalized()*speed
	
func _physics_process(delta) -> void:
	update_velocity()
	move_and_slide()


func _on_hurt_area_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body
		health -= 1
		if health < 1:
			$"..".queue_free()
