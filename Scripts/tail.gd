extends Area2D

const MAX = 0.3;
const SPEED = 20;

var target_node;
var currPos;
var Timer1 = MAX;
var Timer2 = MAX;

func _ready():
	currPos = 0;

#TODO: ADD TAIL DELAY

func _process(deltaTime):
	if (target_node == null): return;

#	if(Timer1 > 0): 
#		Timer1 -= deltaTime;
#		global_position.x = currPos;
#	else:
#		if(position.x > target_node.position.x): position.x -= SPEED;
#		elif(position.x < target_node.position.x): position.x += SPEED;
#
#		if(position.x == 0):
#			currPos = global_position.x;
#			Timer1 = MAX;
