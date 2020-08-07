extends Node

const MAX = 20;
const CHECK = 0.5;

#Temp Value
var BlockScore = 5;

var timer = MAX;
var snake;

var isColliding;
var colliderTimer = CHECK;

func _ready():
	pass;

func _process(deltaTime):
	
	if(isColliding):
		if(colliderTimer > 0): colliderTimer -= deltaTime;
		else: subTail();
	else:
		#Destroy Unseen Blocks after 20 seconds
		if(timer > 0): timer -= deltaTime;
		else: breakBlock();

func _on_Area2D_body_entered(body):
	if(body.name != "SnakeHead"): return;
	
	get_parent().get_node("TouchController/SnakeHead").toggleForward(false);
	isColliding = true;

func _on_Area2D_body_exited(body):
	if(body.name != "SnakeHead"): return;
	
	get_parent().get_node("TouchController/SnakeHead").toggleForward(true);
	isColliding = false;

func breakBlock():
	get_parent().get_node("TouchController/SnakeHead").toggleForward(true);
	get_parent().remove_child(self);
	queue_free();

func subTail():
	#Subtract from Player
	BlockScore -= 1;
	if(BlockScore <= 0): breakBlock();
