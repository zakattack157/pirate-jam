extends Panel

@onready var sprite = $Sprite2D
var target: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func update(whole: bool, frame: int):
	if whole: sprite.frame = 0
	else: sprite.frame = 4
