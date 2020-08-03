extends Node

var rel = Vector2();

var isDragging = false;
var direction = 0;

func _input(event):
	if event is InputEventScreenDrag:  
		rel = event.get_relative().normalized();
		
		if(rel.x > 0): direction = 1;
		elif(rel.x < 0): direction = -1;
		else: direction = direction;

		isDragging = true;
		
	if event is InputEventScreenTouch:
		if (!event.pressed && isDragging):
			direction = 0;
			isDragging = false;
