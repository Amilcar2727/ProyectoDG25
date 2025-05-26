extends CharacterBody2D

@export var speed: float = 300

func _physics_process(_delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_vector * speed
	move_and_slide()
