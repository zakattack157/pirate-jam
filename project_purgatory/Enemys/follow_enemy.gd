class_name FollowMovementC extends Node

@export var speed = 20
@onready var parent: CharacterBody2D = get_parent()

var start_position
var target: Player

@export var health = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_position = parent.position
	
func update_velocity():
	if !target: return #if target is not successfully set
	
	var direction = target.global_position - parent.global_position
	var new_velocity = direction.normalized() * speed
	parent.velocity = new_velocity
	
func _physics_process(delta: float) -> void:
	update_velocity()
	parent.move_and_slide()
	
func _on_follow_area_body_entered(body):
	if body is Player:
		target = body
		health -= 1
		if health < 1:
			$"..".queue_free()
