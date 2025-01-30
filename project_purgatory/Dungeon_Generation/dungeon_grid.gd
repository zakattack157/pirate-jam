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
	
	#creates the grid for dungeon generation
	var dungeon_grid = create_2d_array(rows,cols, 0)
	#call depth first search to prepare grid for rooms
	dungeon_grid = dfs(dungeon_grid, start_row, start_col)
	#places rooms with info from the dfs
	place_rooms_in_grid(dungeon_grid)


func create_2d_array(rows: int, cols: int, default_value = 0) -> Array:
	var array_2d = []
	for i in range(rows):
		array_2d.append([])
		for j in range(cols):
			array_2d[i].append(default_value)
	return array_2d

#depth first search for dungeon generation
func dfs(grid: Array, start_row: int, start_col: int)->Array:
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
	
	#static room placed at center of grid
	var rooms_placed = 1
	grid[start_row][start_col] = 1
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
			if is_in_bounds(grid, new_row, new_col) and grid[new_row][new_col] == 0:
				grid[new_row][new_col] = 1
				stack.append(Vector2(new_row, new_col))
				rooms_placed += 1
				found_next_room = true
				break
				
		if not found_next_room:
			stack.pop_back()
	return grid	


func is_in_bounds(grid: Array, row: int, col: int) -> bool:
	return row >= 0 and row < len(grid) and col >= 0 and col < len(grid[0])

#helper function that instantiates the chosen room in place_rooms_in_grid
func add_room(row: int, col: int, doors: String):
	var room_scene = get_room_scenes(doors)
	if not room_scene:
		return

	var room_instance = room_scene.instantiate()
	var globalposition = Vector2((col - start_col) * room_width, (row - start_row) * room_height)
	room_instance.position = globalposition
	add_child(room_instance)
	

#main function for placing rooms in grid
func place_rooms_in_grid(grid: Array):
	for row in range(len(grid)):
		for col in range(len(grid[row])):
			if grid[row][col] == 1:
				var doors = get_correct_room_prefab(grid, row, col)
				add_room(row, col, doors)

#helper function that determines which room prefab is used in place_rooms_in_grid
func get_correct_room_prefab(grid: Array, row: int, col: int) -> String:
	var doors = ""
	
	if is_in_bounds(grid, row-1, col) and grid[row-1][col] == 1:
		doors += "U"
	if is_in_bounds(grid, row+1, col) and grid[row+1][col] == 1:
		doors += "D"
	if is_in_bounds(grid, row, col-1) and grid[row][col-1] == 1:
		doors += "L"
	if is_in_bounds(grid, row, col+1) and grid[row][col+1] == 1:
		doors += "R"
	return doors

#uses value from get_correct_room_prefab to call the correct scene to place room
func get_room_scenes(doors: String)-> PackedScene:
	match doors:
		"U": return preload("res://RoomScenes/RoomUp.tscn")
		"D": return preload("res://RoomScenes/RoomDown.tscn")
		"L": return preload("res://RoomScenes/RoomLeft.tscn")
		"R": return preload("res://RoomScenes/RoomRight.tscn")
		"UD": return preload("res://RoomScenes/RoomUD.tscn")
		"UL": return preload("res://RoomScenes/RoomUL.tscn")
		"DR": return preload("res://RoomScenes/RoomDR.tscn")
		"DL": return preload("res://RoomScenes/RoomDL.tscn")
		"UR": return preload("res://RoomScenes/RoomUR.tscn")
		"LR": return preload("res://RoomScenes/RoomLR.tscn")
		"UDL": return preload("res://RoomScenes/RoomUDL.tscn")
		"UDR": return preload("res://RoomScenes/RoomUDR.tscn")
		"ULR": return preload("res://RoomScenes/RoomULR.tscn")
		"DLR": return preload("res://RoomScenes/RoomDLR.tscn")
		"UDLR": return preload("res://RoomScenes/RoomUDLR.tscn")
		_: return preload("res://RoomScenes/StartingRoom.tscn")
