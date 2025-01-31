class_name Boss extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var speed = 40
@export var limit = 0.5
@export var health = 15

var projectile_scene = preload("res://projectile.tscn")
var start_position
var end_position


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("boss_anim")
	start_position = position
	end_position = start_position - Vector2(2*32, 0)
	
	await get_tree().create_timer(randf_range(0.25, 0.55)).timeout
	$ShootTimer.wait_time = randf_range(1, 1)
	$ShootTimer.start()
	
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


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is Player:
			health -= 1
			if health < 1:
				$"..".queue_free()
	
func _on_shoot_timer_timeout() -> void:
	var p = projectile_scene.instantiate()
	get_tree().root.add_child(p)
	$ShootTimer.wait_time = randf_range(1, 1)
	$ShootTimer.start()
