extends Node

const debug = true;

const TempNumber = 0;

var GAP = 5;
var timer = 0;

var Point1 = Vector2();
var Point2 = Vector2();
var Point3 = Vector2();
var Point4 = Vector2();

onready var block = preload("res://Scenes/Block.tscn");
onready var point = preload("res://Scenes/point.tscn");

var PresetNumber = TempNumber;

func _ready():
	pass;

func _process(deltaTime):
	if(debug): return;
	
	if(timer >= 0): timer -= deltaTime;
	else:
		SpawnPreset();
		timer = GAP;

func SpawnPreset():
	#LOCATE POINTS
	Point1 = get_node("Point1").global_position;
	Point2 = get_node("Point2").global_position;
	Point3 = get_node("Point3").global_position;
	Point4 = get_node("Point4").global_position;
	
	#GENERATE RANDOM NUMBER BETWEEN 0-9
	PresetNumber = randi() % 9;
	
	match(PresetNumber):
		0:
			SpawnBlock(1);
			SpawnBlock(2);
			SpawnBlock(3);
			SpawnBlock(4);
		1:
			SpawnBlock(1);
			SpawnBlock(2);
			SpawnPoint(3);
			SpawnPoint(4);
		2:
			SpawnPoint(1);
			SpawnPoint(2);
			SpawnBlock(3);
			SpawnBlock(4);
		3:
			SpawnBlock(1);
			SpawnPoint(2);
			SpawnBlock(3);
			SpawnPoint(4);
		4:
			SpawnPoint(1);
			SpawnBlock(2);
			SpawnPoint(3);
			SpawnBlock(4);
		5:
			SpawnBlock(1);
			SpawnPoint(2);
			SpawnPoint(3);
			SpawnPoint(4);
		6:
			SpawnPoint(1);
			SpawnBlock(2);
			SpawnPoint(3);
			SpawnPoint(4);
		7:
			SpawnPoint(1);
			SpawnPoint(2);
			SpawnBlock(3);
			SpawnPoint(4);
		8:
			SpawnPoint(1);
			SpawnPoint(2);
			SpawnPoint(3);
			SpawnBlock(4);
	
	timer = GAP;

#BLOCKS
func SpawnBlock(thisPosition):
	var OffsetX = 620;
	var OffsetY = 800;
	
	var inst = block.instance();
	if(thisPosition == 1):   inst.position = Vector2(Point1.x - OffsetX, Point1.y - OffsetY);
	elif(thisPosition == 2): inst.position = Vector2(Point2.x - OffsetX, Point2.y - OffsetY);
	elif(thisPosition == 3): inst.position = Vector2(Point3.x - OffsetX, Point3.y - OffsetY);
	elif(thisPosition == 4): inst.position = Vector2(Point4.x - OffsetX, Point4.y - OffsetY);
	
	add_child(inst);
	
	var bloc = inst;
	remove_child(bloc);
	get_parent().get_parent().add_child(bloc);

func SpawnPoint(thisPosition):
	#GENERATE NUMBER
	PresetNumber = randi() % 2;
	if(PresetNumber == 0): return;
	
	var OffsetX = 620;
	var OffsetY = 1400;
	
	#TODO: CHANGE BLOCK FOR POINT
	var inst = point.instance();
	if(thisPosition == 1):   inst.position = Vector2(Point1.x - OffsetX, Point1.y - OffsetY);
	elif(thisPosition == 2): inst.position = Vector2(Point2.x - OffsetX, Point2.y - OffsetY);
	elif(thisPosition == 3): inst.position = Vector2(Point3.x - OffsetX, Point3.y - OffsetY);
	elif(thisPosition == 4): inst.position = Vector2(Point4.x - OffsetX, Point4.y - OffsetY);
	
	add_child(inst);
	
	var poin = inst;
	remove_child(poin);
	get_parent().get_parent().add_child(poin);
