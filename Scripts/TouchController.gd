extends KinematicBody2D

const UP = Vector2(0, -1);
const SPEED = 6000; # pixel per second
const MAX_TRACKING_DISTANCE = 50; # pixel
const SMALLEST_REGISTERED_OFFSET = 1.0;

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
		
		var direction = next_offset.normalized().x;
		var distance = next_offset.length();
		var reach = SPEED * 0.078;

		print(direction);

		if distance > reach:
			motion.x += direction * reach;
			path[0] *= 1-reach/distance;
		else:
			while distance <= reach:
				motion.x += direction * distance;
				reach -= distance;
				path.pop_front();

				if path.empty(): return
				next_offset = path.front();
				direction = next_offset.normalized().x;
				distance = next_offset.length();

#			if distance > reach:
#				motion.x += direction * reach;
#				path[0] *= 1-reach/distance;
		
	motion = move_and_slide(motion, UP);

