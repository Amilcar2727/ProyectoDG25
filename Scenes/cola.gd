extends CharacterBody2D

class_name cola

var lista = []

func _init(val = []):
	self.lista = val
	
func add(elemento):
	if elemento:
		self.lista.append(elemento)
func pop():
	if (self.lista.size() > 0):
		self.lista.pop_back()
func last():
	if (self.lista.size() > 0):
		return self.lista.back()
	else:
		return "null"
