extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.position += Vector2(0, 150)
		#var camera = body.get_node("Camera2D")
		#camera.set_position_smoothing_enabled(true)
		#body.can_move = false
		#await get_tree().create_timer(1.5).timeout
		#
		#camera.set_position_smoothing_enabled(false)
		#body.can_move = true
	
