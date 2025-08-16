# res://SceneManager.gd

extends Node

var current_scene: Node = null

func change_scene_to(path: String):
	if current_scene:
		current_scene.queue_free()
	var new_scene = load(path).instantiate()
	get_tree().root.add_child(new_scene)
	current_scene = new_scene
