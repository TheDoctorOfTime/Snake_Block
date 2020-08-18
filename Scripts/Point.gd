extends Area2D

var timer = 30;
var score = 0;
var difficulty = 0;

func setScore():
	difficulty = get_parent().get_node("TouchController/SnakeHead").difficulty;
	
	if(difficulty == 1):   score = randi() % 5 + 1;
	elif(difficulty == 2): score = randi() % 10 + 6;
	else: score = randi() % 15 + 11;
	
	get_node("Score").bbcode_text = str("[center]", score);

func _process(deltaTime):
	
	if(score == 0):
		if(get_parent().get_node("TouchController/SnakeHead") != null): setScore();
	
	if(timer > 0): timer -= deltaTime;
	else:
		get_parent().remove_child(self);
		pass;

func _on_Area2D_body_entered(body):
	if(body.name != "SnakeHead"): return;
	
	get_parent().get_node("TouchController/SnakeHead").add(score);
	
	get_parent().remove_child(self);
