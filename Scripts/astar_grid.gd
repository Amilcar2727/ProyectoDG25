extends AStar2D

var grid_size: Vector2i
var cell_size: int = 64  # Tamaño de tus celdas
var obstacles: Array = []

func _init(map_size: Vector2i, obstacles_array: Array):
	grid_size = map_size
	obstacles = obstacles_array
	_create_grid()

func _create_grid():
	# Agregar todos los puntos
	for y in grid_size.y:
		for x in grid_size.x:
			var point_id = _get_point_id(Vector2i(x, y))
			add_point(point_id, Vector2(x, y))
	
	# Conectar los puntos
	for y in grid_size.y:
		for x in grid_size.x:
			var current_id = _get_point_id(Vector2i(x, y))
			
			# Vecinos (incluyendo diagonales)
			var neighbors = [
				Vector2i(x + 1, y),
				Vector2i(x - 1, y),
				Vector2i(x, y + 1),
				Vector2i(x, y - 1),
				Vector2i(x + 1, y + 1),
				Vector2i(x - 1, y - 1),
				Vector2i(x + 1, y - 1),
				Vector2i(x - 1, y + 1)
			]
			
			for neighbor in neighbors:
				if _is_in_bounds(neighbor) && !_is_obstacle(neighbor):
					var neighbor_id = _get_point_id(neighbor)
					connect_points(current_id, neighbor_id)

func _get_point_id(position: Vector2i) -> int:
	return position.x + position.y * grid_size.x

func _is_in_bounds(point: Vector2i) -> bool:
	return point.x >= 0 && point.x < grid_size.x && point.y >= 0 && point.y < grid_size.y

func _is_obstacle(point: Vector2i) -> bool:
	return obstacles.has(point)

func get_path(start: Vector2, end: Vector2) -> PackedVector2Array:
	var start_grid = world_to_grid(start)
	var end_grid = world_to_grid(end)
	
	var path = []
	var start_id = _get_point_id(start_grid)
	var end_id = _get_point_id(end_grid)
	
	if has_point(start_id) && has_point(end_id):
		path = get_point_path(start_id, end_id)
	
	return path

func world_to_grid(world_pos: Vector2) -> Vector2i:
	return Vector2i(world_pos / cell_size)

func grid_to_world(grid_pos: Vector2i) -> Vector2:
	return Vector2(grid_pos) * cell_size + Vector2(cell_size/2, cell_size/2)
