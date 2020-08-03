extends KinematicBody2D

const UP = Vector2(0, -1);
const SPEED = 2000;
const SMOOTHING = 250;

var motion = Vector2();
var direction = 0;
var velocity = 0;

var forwardMovement = 0.2;

var snakeLength = 4;

func _ready():
	pass
	
func _process(deltaTime):
	direction = get_parent().direction;
	pass;

func _physics_process(deltaTime):
	
	if direction != 0: velocity = direction * SPEED;
	elif direction == 0:
		if velocity != 0:
			if velocity < 0: velocity += SMOOTHING;
			if velocity > 0: velocity -= SMOOTHING;
	
	motion.x = velocity;
	motion.y -= forwardMovement;
	motion = move_and_slide(motion, UP);

#TODO: DamageClass  (occurs when snake contacts block, subtracts snake length)
#TODO: AddToLength  (occurs when snake contacts length orb[?not sure what you call that thing])
#TODO: KillSnake    (occurs when the snakeLength variable <= 0, triggers death)
#TODO: WinLevel     (occurs when level is completed, moves player to next level)
#TODO: BASIC UI     (Length Display, Phase, Level, etc. [text-only, I'll leave UI design to the artist'])
#TODO: TRAIL RENDER (display [snakeLength - 1] body dots behind the head)
