extends Node2D

@onready var hearts_container = $CanvasLayer/heartsContainer
@onready var player = $Player1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hearts_container.setMaxHearts(player.max_health)
	hearts_container.updateHearts(player.current_health)
	player.healthChanged.connect(hearts_container.updateHearts)
