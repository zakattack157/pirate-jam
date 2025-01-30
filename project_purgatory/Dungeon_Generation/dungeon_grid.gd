extends Node

#Size of dungeon grid
var rows = 9
var cols = 7

#Room Info
const ROOM_PATH = "res://RoomScenes/StartingRoom.tscn"
const PLAYER_PATH = "res://TestPlayer/player.tscn"
var room_scene = preload(ROOM_PATH) as PackedScene



#Room size
var room_width = 288
var room_height = 255


#Center of grid setup for BFS
var start_row = 4
var start_col = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	var dungeon_grid = create_2d_array(rows,cols, 0)
			
	dfs(dungeon_grid, start_row, start_col)



func create_2d_array(rows: int, cols: int, default_value = 0) -> Array:
	var array_2d = []
	for i in range(rows):
		array_2d.append([])
		for j in range(cols):
			array_2d[i].append(default_value)
	return array_2d

#depth first search for dungeon generation
func dfs(grid: Array, start_row: int, start_col: int):
	var directions = [
		Vector2(-1, 0), #UP
		Vector2(1, 0),  #DOWN
		Vector2(0, -1), #LEFT
		Vector2(0,1),   #RIGHT
	]
	
	#DFS Stack
	var stack = []
	stack.append(Vector2(start_row,start_col))

	var visited = create_2d_array(len(grid), len(grid[0]), false)
	visited[start_row][start_col] = true
	
	var rooms_placed = 1
	add_room(start_row, start_col)
	#start BFS
	while stack.size() > 0 and rooms_placed < 10:
		var current = stack[-1] #peeks top of stack
		var row = current.x
		var col = current.y
		
		directions.shuffle()
		
		
		var found_next_room = false
		
		for direction in directions:
			var new_row = row + direction.x
			var new_col =col + direction.y
			
			#check bounds and if cell is already visited
			if is_in_bounds(grid, new_row, new_col) and not visited[new_row][new_col]:
				visited[new_row][new_col] = true
				stack.append(Vector2(new_row, new_col))
				
				add_room(new_row, new_col)
				rooms_placed += 1
				found_next_room = true
				break
				
		if not found_next_room:
			stack.pop_back()
				
func is_in_bounds(grid: Array, row: int, col: int) -> bool:
	return row >= 0 and row < len(grid) and col >= 0 and col < len(grid[0])
			
func add_room(row: int, col: int):
	var room_instance = room_scene.instantiate()
	
	var globalposition = Vector2((col - start_col) * room_width, (row - start_row) * room_height)
	
	room_instance.position = globalposition
	
	
	add_child(room_instance)
