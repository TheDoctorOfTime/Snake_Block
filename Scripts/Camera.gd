extends Node2D

var snakeHead;
var isDead = false;

var currentPos = Vector2();

func _ready():
	snakeHead = get_parent().get_node("TouchController").get_node("SnakeHead");

func _process(deltaTime):
	if(isDead): return;
	
	position = Vector2(currentPos.x, snakeHead.position.y-600)
