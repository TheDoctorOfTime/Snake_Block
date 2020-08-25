extends Line2D

var target;
var point;

export(NodePath) var targetPath;
var trailLength = 20;

func _ready():
	target = get_node(targetPath);
	
func _process(deltaTime):
	point = Vector2(target.position.x, target.position.y + 35);
	add_point(point);
	
	while get_point_count() > trailLength:
		remove_point(0);
