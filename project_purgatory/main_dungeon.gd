extends Node2D

@onready var hearts_container = $CanvasLayer/heartsContainer
@onready var player = $Player/CharacterBody2D
@export var enemy_follow_scene: PackedScene
@export var enemy_walk_scene: PackedScene

var score
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hearts_container.setMaxHearts(player.max_health)
	hearts_container.updateHearts(player.current_health)
	player.healthChanged.connect(hearts_container.updateHearts)
	spawn_follow_enemy()
	
func spawn_follow_enemy() -> void:
	var random_number = rng.randf_range(1, 4)
	for n in random_number:
		var mob = enemy_follow_scene.instantiate()
		
		var mob_spawn_loc = $EnemyPath/EnemySpawnLocation
		mob_spawn_loc.progress_ratio = randf()
		
		var direction = mob_spawn_loc.rotation + PI / 2
		mob.position = mob_spawn_loc.position
		
		add_child(mob)

func spawn_walk_enemy() -> void:
	var random_number = rng.randf_range(1, 4)
	for n in random_number:
		var mob1 = enemy_walk_scene.instantiate()
		
		var mob1_spawn_loc = $EnemyPath/EnemySpawnLocation
		mob1_spawn_loc.progress_ratio = randf()
		
		var direction = mob1_spawn_loc.rotation + PI / 2
		mob1.position = mob1_spawn_loc.position
		
		add_child(mob1)
