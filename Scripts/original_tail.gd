extends KinematicBody2D

const UP = Vector2(0, -1);
const MAX = 0.01;
const MAX2 = 0.001;

var SPEED = 450;
var speed;
var CORRECTION_SPEED = 5;
var SMOOTHING = 25;
var tailNum;

var target_node;
var currPos;
var nextPos;
var baseY;
var y;

var timer1 = MAX;
var timer2 = MAX2;
var timer3 = MAX;

var direction = 0;
var velocity = 0;
var motion = Vector2();

func _ready():
#	if(tailNum == 1): SPEED = 450;
#	elif(tailNum == 2): SPEED = 405;
#	elif(tailNum == 3): SPEED = 360;
#	elif(tailNum == 4): SPEED = 315;
#	elif(tailNum == 5): SPEED = 270;
#	elif(tailNum == 6): SPEED = 225;
#	elif(tailNum == 7): SPEED = 180;
#	else: SPEED = 135;
	
#	SPEED = 450;
	
	baseY = position.y;
	currPos = global_position.x;


func _process(deltaTime):	
	if (target_node == null): return;
	
	nextPos = target_node.global_position.x
	
	if(timer1 > 0): 
		timer1 -= deltaTime;
		global_position.x = currPos;
	else:
		if(timer2 > 0): timer2 -= deltaTime;
		else:
			if(global_position.x > nextPos): direction = -1;
			elif(global_position.x < nextPos): direction = 1;
			else: direction = 0;
			timer2 = MAX2;
		
		if(position.x > 0 && position.x < 5):
			speed = 1;
		elif(position.x < 0 && position.x > -5):
			speed = 1;
		else:
			speed = SPEED;
		
		currPos = global_position.x;
		timer1 = MAX;

func _physics_process(deltaTime):
	
	if direction != 0: velocity = direction * speed;
	elif direction == 0:
		if velocity != 0:
			if velocity < 0: velocity += SMOOTHING;
			if velocity > 0: velocity -= SMOOTHING;
	
	motion.x = velocity;
	motion.y = 0;
	
	motion = move_and_slide(motion, UP);
