extends Node

const MAX = 20;
const CHECK = 0.4;

var difficulty = 1;
var BlockScore = 0;

var timer = MAX;
var snake;

var isColliding;
var colliderTimer = CHECK;

func setScore():
	difficulty = get_parent().get_node("TouchController/SnakeHead").difficulty;
	
	if  (difficulty == 1): BlockScore = randi()%5+1;
	elif(difficulty == 2): BlockScore = randi()%10+6;
	elif(difficulty == 3): BlockScore = randi()%25+11;
	elif(difficulty == 4): BlockScore = randi()%50+26;
	elif(difficulty == 5): BlockScore = randi()%75+51;
	
	get_node("Score").bbcode_text = str("[center]", BlockScore);

func _process(deltaTime):
	
	if(BlockScore == 0):
		if(get_parent().get_node("TouchController/SnakeHead") != null): setScore();
	
	if(isColliding):
		if(colliderTimer > 0): 
			colliderTimer -= deltaTime;
		else: subScore();
	else:
		#Destroy Unseen Blocks after 20 seconds
		if(timer > 0): timer -= deltaTime;
		else: breakBlock();

func _on_Area2D_body_entered(body):
	if(body == null): return;
	if(body.name == "SnakeHead"):
		get_parent().get_node("TouchController/SnakeHead").toggleForward(false);
		get_parent().get_node("MainCamera").shake();
		subScore();
	
		isColliding = true;
	else:
		var delete = get_parent().find_node(body.name);
		get_parent().remove_child(delete);

func _on_Area2D_body_exited(body):
	if(body == null): return;
	if(body.name != "SnakeHead"): return;
	
	get_parent().get_node("TouchController/SnakeHead").toggleForward(true);
	isColliding = false;

func breakBlock():
	get_parent().get_node("TouchController/SnakeHead").toggleForward(true);
	get_parent().remove_child(self);
	queue_free();

func subScore():
	#Subtract from Player
	BlockScore -= 1;
	get_parent().get_node("MainCamera").shake();
	get_parent().get_node("TouchController/SnakeHead").subTail();
	get_node("ParticleController").emitting = true;
	get_node("Score").bbcode_text = str("[center]", BlockScore);
	colliderTimer = CHECK;
	
	#get_parent().get_node("TouchController/SnakeHead").repositionY();
	if(BlockScore <= 0): breakBlock();
