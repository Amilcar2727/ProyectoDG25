extends CharacterBody2D


@export var speed: float = 300
	
class lastmove:
	var lista = []
	var v1: bool = false
	var v2: bool = false
	func update(valor1, valor2):
		if valor1 == true:
			if v1 == false:
				self.lista.append("v1")
				v1 = true
		else:
			if v1 == true:
				self.lista.erase("v1")
				v1 = false
		if valor2 == true:
			if v2 == false:
				self.lista.append("v2")
				v2 = true
		else:
			if v2 == true:
				self.lista.erase("v2")
				v2 = false		
	
				
	

var lastx = lastmove.new()
var lasty = lastmove.new()

func _physics_process(_delta):
	var input_direction: Vector2
	var p_up = Input.is_action_pressed("ui_up")
	var p_down = Input.is_action_pressed("ui_down")
	var p_left = Input.is_action_pressed("ui_left")
	var p_right = Input.is_action_pressed("ui_right")
	lastx.update(p_left,p_right)
	lasty.update(p_up,p_down)
	
	if lastx.lista.size() == 0:
		input_direction.x = 0
	elif lastx.lista.back() == "v2":
		input_direction.x = 1
	else:
		input_direction.x = -1
	if lasty.lista.size() == 0:
		input_direction.y = 0
	elif lasty.lista.back() == "v2":
		input_direction.y = 1
	else:
		input_direction.y = -1
	input_direction.normalized()

	
	velocity = input_direction * speed
				
	

	move_and_slide()
