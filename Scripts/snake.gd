extends KinematicBody2D

const UP = Vector2(0, -1);
const SPEED = 2000;
const SMOOTHING = 250;
const GAP = 80;

var motion = Vector2();
var direction = 0;
var velocity = 0;

var forwardMovement = 2;
var movingForward = true;

var snakeLength = 4;

var prevDir = 0;
var nextDir = 0;

var currPos;
onready var Tail = preload("res://Scenes/tail.tscn");

func _ready():
	
	addTail();
	addTail();
	addTail();
	addTail();
	pass;
	
func _process(deltaTime):
	direction = get_parent().direction;
	

func _physics_process(deltaTime):
	if direction != 0: velocity = direction * SPEED;
	elif direction == 0:
		if velocity != 0:
			if velocity < 0: velocity += SMOOTHING;
			if velocity > 0: velocity -= SMOOTHING;
	
	motion.x = velocity;
	if(movingForward): motion.y -= forwardMovement;
	else: motion.y = 0;
	
	motion = move_and_slide(motion, UP);

#TODO: DamageClass  (occurs when snake contacts block, subtracts snake length)
#TODO: AddToLength  (occurs when snake contacts length orb[?not sure what you call that thing])
#TODO: KillSnake    (occurs when the snakeLength variable <= 0, triggers death)
#TODO: WinLevel     (occurs when level is completed, moves player to next level)
#TODO: BASIC UI     (Length Display, Phase, Level, etc. [text-only, I'll leave UI design to the artist'])

func addTail():
	var inst = Tail.instance();
	var prev_tail = get_child(get_child_count() -1);
	if(prev_tail.name != "Head"):
		inst.target_node = prev_tail;
	else:
		inst.target_node = get_parent().get_node("SnakeHead");
	
	inst.position = Vector2(0, prev_tail.position.y + GAP);
	
	add_child(inst);

func toggleForward(value):
	movingForward = value;
