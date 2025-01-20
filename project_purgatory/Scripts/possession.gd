# Possession node allows the player to possess nearby objects.
extends Node2D

# Objects the player has added to their transformable objects list
var possessable_inventory: Array[Node] = []

@onready var possession_radius: Area2D = $PossessionRadius
var possessable_objects_in_radius: Array[Node] = []

# Possessable object within the possesion radius closest to the player. Updated each frame.
var closest_possessable: Node

# Material to apply to the sprite of the nearest possessable object.
var possessable_material: Material

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_closest_possessable()
	
	if Input.is_action_just_pressed("possess"):
		possess_closest_possessable()
	
func possess_closest_possessable() -> void:
	print(str(closest_possessable)+" is the closest possessable");
	# TODO: possess the closest possessable

func update_closest_possessable():
	closest_possessable = null
	var closest_distance = INF
	
	for obj in possessable_objects_in_radius:
		var distance = global_transform.origin.distance_to(obj.global_transform.origin)
		if distance < closest_distance:
			closest_distance = distance
			closest_possessable = obj

func _on_possession_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("possessable"):
		possessable_objects_in_radius.append(body);
		var sprite: Sprite2D = body.get_node("Sprite2D")
		if sprite and sprite.material:
			sprite.material.set_shader_parameter("width", 1.0)
	
func _on_possession_radius_body_exited(body: Node2D) -> void:
	possessable_objects_in_radius.erase(body);
	var sprite: Sprite2D = body.get_node("Sprite2D")
	if sprite and sprite.material:
		sprite.material.set_shader_parameter("width", 0.0)
