extends HBoxContainer

@onready var heart_gui_class = preload("res://TestPlayer/health/hearts_gui.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func setMaxHearts(max: int):
	for i in range(max):
		var heart = heart_gui_class.instantiate()
		add_child(heart)
func updateHearts(current_health: int):
	var hearts = get_children()
	var health = current_health
	for i in range(current_health):
		hearts[i].update(true, health)
		for j in range(current_health, hearts.size()):
			hearts[j].update(false, health)
	
