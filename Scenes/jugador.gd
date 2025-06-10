extends CharacterBody2D


@export var speed: float = 300

var lastmove: int = 0
var diff: int = 0
	

func _physics_process(_delta):
	var input_direction: Vector2
	input_direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")).normalized();
	
	var p_up = Input.is_action_pressed("ui_up")
	var p_down = Input.is_action_pressed("ui_down")
	var p_left = Input.is_action_pressed("ui_left")
	var p_right = Input.is_action_pressed("ui_right")
	var move: int = (int(p_up)<<3) + (int(p_down)<<2) + (int(p_right)<<1) + (int(p_left)<<0) 
	
	velocity = input_direction * speed
				
	

	move_and_slide()
