extends KinematicBody2D

const UP = Vector2(0, -1);
const SPEED = 450;
const SMOOTHING = 25;
const GAP = 80;

var motion = Vector2();
var direction = 0;
var velocity = 0;

var forwardMovement = 250;
var movingForward = true;

var snakeLength = 1;
export(int) var difficulty = 1;
var difficultyUpTimer = 30;

var currPos;
onready var Tail = preload("res://Scenes/tail.tscn");

func _ready():
	for x in range(10):
		addTail();
	
func _process(deltaTime):
	if(snakeLength <= 0): get_tree().reload_current_scene();
	
	if(difficultyUpTimer > 0): difficultyUpTimer -= deltaTime;
	else:
		match(difficulty):
			1: difficultyUpTimer = 60;
			2: difficultyUpTimer = 90;
			3: difficultyUpTimer = 120;
			4: difficultyUpTimer = 120;
		
		if(difficulty < 5): difficulty += 1;
	direction = get_parent().direction;

func _physics_process(deltaTime):
	
	if direction != 0: velocity = direction * SPEED;
	elif direction == 0:
		if velocity != 0:
			if velocity < 0: velocity += SMOOTHING;
			if velocity > 0: velocity -= SMOOTHING;
	
	motion.x = velocity;
	if(movingForward): motion.y = -1*forwardMovement;
	else: motion.y = 0;
	
	motion = move_and_slide(motion, UP);

#TODO: WinLevel     (occurs when level is completed, moves player to next level)
#TODO: BASIC UI     (Length Display, Phase, Level, etc. [text-only, I'll leave UI design to the artist'])

func addTail():
	snakeLength += 1;
	var inst = Tail.instance();
	var prev_tail = get_child(get_child_count() -1);
	if(prev_tail.name != "Head"): inst.target_node = prev_tail;
	else: inst.target_node = get_parent().get_node("SnakeHead");
	
	inst.tailNum = snakeLength;
	inst.position = Vector2(0, prev_tail.position.y + GAP);
	
	add_child(inst);

func toggleForward(value): movingForward = value;

func subTail():
	var tailEnd = get_child(get_child_count() -1);
	
	snakeLength -= 1;
	if(tailEnd.name == "Head"): return;
	
	remove_child(tailEnd);
