extends AStar2D
class_name AStarGrid 

var grid_size: Vector2i
var cell_size: int = 64
var obstacles: Array = []

# Constructor personalizado
func _init(map_size: Vector2i, obstacles_array: Array):
	grid_size = map_size
	obstacles = obstacles_array
	_create_grid()

func _create_grid():
	# Agregar puntos al grid
	for y in grid_size.y:
		for x in grid_size.x:
			var point_id = _calculate_id(x, y)
			add_point(point_id, Vector2(x, y))
	
	# Conectar puntos (solo horizontal/vertical para simplificar)
	for y in grid_size.y:
		for x in grid_size.x:
			var current_id = _calculate_id(x, y)
			# Vecinos: derecha, izquierda, abajo, arriba
			var neighbors = [
				Vector2i(x + 1, y),
				Vector2i(x - 1, y),
				Vector2i(x, y + 1),
				Vector2i(x, y - 1)
			]
			for neighbor in neighbors:
				if _is_in_grid(neighbor) && !obstacles.has(neighbor):
					var neighbor_id = _calculate_id(neighbor.x, neighbor.y)
					if !are_points_connected(current_id, neighbor_id):
						connect_points(current_id, neighbor_id)

func _calculate_id(x: int, y: int) -> int:
	return x + y * grid_size.x

func _is_in_grid(point: Vector2i) -> bool:
	return point.x >= 0 && point.x < grid_size.x && point.y >= 0 && point.y < grid_size.y

func get_path(start_world: Vector2, end_world: Vector2) -> PackedVector2Array:
	var start_grid = Vector2i(start_world / cell_size)
	var end_grid = Vector2i(end_world / cell_size)
	
	var path: PackedVector2Array = []
	var start_id = _calculate_id(start_grid.x, start_grid.y)
	var end_id = _calculate_id(end_grid.x, end_grid.y)
	
	if has_point(start_id) && has_point(end_id):
		path = get_point_path(start_id, end_id)
		# Convertir coordenadas del grid a mundo
		for i in path.size():
			path[i] = path[i] * cell_size + Vector2(cell_size/2, cell_size/2)
	
	return path
