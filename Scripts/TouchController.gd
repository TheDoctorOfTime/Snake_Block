extends KinematicBody2D

const UP = Vector2(0, -1);
const SPEED = 1200;
const forwardMovement = 750;
const MAX_I = 6;

var touching = false;
var dragging = false;

var direction = 0;
var motion = Vector2();

var isHead;

var iteration = MAX_I;

func _ready():
	motion.y = -1 * forwardMovement;

func _input(event):
	if event is InputEventScreenTouch:
		if(event.pressed && !touching): touching = true;
		if(!event.pressed && touching): touching = false;
	
	if event is InputEventScreenDrag:
		dragging = true;
		direction = event.relative.normalized().x;
		
	if(dragging && !touching):
		dragging = false;
		direction = 0;

func _physics_process(deltaTime):
	motion.x = direction * SPEED;
	motion = move_and_slide(motion, UP);
