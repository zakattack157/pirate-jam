extends Area2D

@export var speed = 40

func start(pos):
	position = pos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		queue_free()
