extends CharacterBody2D

@export var speed: float = 150
var target: Node2D
var astar: AStarGrid
var path: PackedVector2Array = []

func _ready():
	target = get_tree().get_first_node_in_group("player")  # Asegúrate de que el jugador tenga el grupo "player"
	# Obtener obstáculos del TileMap
	var tilemap = get_node("../TileMap")  # Ajusta la ruta según tu escena
	var obstacles = _get_obstacles(tilemap)
	# Crear el grid A* (ejemplo para mapa de 50x50)
	astar = AStarGrid.new(Vector2i(50, 50), obstacles)

func _physics_process(delta):
	if target:
		update_path()
		follow_path(delta)

func update_path():
	path = astar.get_path(global_position, target.global_position)

func follow_path(delta):
	if path.size() == 0:
		return
	
	var target_position = path[0]
	var direction = global_position.direction_to(target_position)
	velocity = direction * speed
	
	if global_position.distance_to(target_position) < 5:
		path.remove_at(0)
	
	move_and_slide()

func _get_obstacles(tilemap: TileMap) -> Array:
	var obstacles = []
	var used_cells = tilemap.get_used_cells(0)  # Capa 0
	for cell in used_cells:
		var data = tilemap.get_cell_tile_data(0, cell)
		if data && data.get_custom_data("obstacle"):  # Asegúrate de configurar esto en tu TileSet
			obstacles.append(cell)
	return obstacles
