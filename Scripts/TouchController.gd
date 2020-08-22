extends KinematicBody2D

const UP = Vector2(0, -1);
const SPEED = 10000; # pixel per second
const MAX_TRACKING_DISTANCE = 500; # pixel
const SMALLEST_REGISTERED_OFFSET = 0.5;

var screen_touch = false;
var path = [];

var motion = Vector2();

var isHead;

var forwardMovement = 750;

func _ready():
	motion.y = -1 * forwardMovement;

func _input(event):
	if event is InputEventScreenTouch:
		screen_touch = event.pressed;
		if(!screen_touch): path.clear();
		
	elif event is InputEventScreenDrag and screen_touch:
		var distance = position.distance_to(event.position);
		
		if distance <= MAX_TRACKING_DISTANCE:
			if event.relative.length() >= SMALLEST_REGISTERED_OFFSET:
				path.push_back(event.relative);
		else:
			path.clear();
			path.push_back(position.direction_to (event.position) * distance);

func _physics_process(deltaTime):	
	
	if(!path.empty()):
		motion.y = -1 * forwardMovement;
		var next_offset = path.front();
		
		next_offset.y = 0;
		
		var direction = next_offset.normalized().x;
		var distance = next_offset.length();
		var reach = SPEED * deltaTime;
		var difference = SPEED * (deltaTime*2);

		if distance > reach:
			motion.x += direction * difference;
			path[0] *= 1-reach/distance;
		else:
			while distance <= reach:
				motion.x += direction * difference;
				reach -= distance;
				path.pop_front();

				if path.empty(): return
				next_offset = path.front();
				direction = next_offset.normalized().x;
				distance = next_offset.length();

			if distance > reach:
				motion.x += direction * difference;
				path[0] *= 1-reach/distance;
	else:
		motion.x = 0;
		
	motion = move_and_slide(motion, UP);


