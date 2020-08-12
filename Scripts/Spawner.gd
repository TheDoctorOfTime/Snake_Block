extends Node

const TempNumber = 0;

var GAP = 5;
var timer = 0;

var Point1 = Vector2();
var Point2 = Vector2();
var Point3 = Vector2();
var Point4 = Vector2();

onready var block = preload("res://Scenes/Block.tscn");

#PRESETS 
#(Playing the Game I couldn't find an instance where 3 would spawn at a time)
#OOOO - 1234 - 0
#OOXX - 1200 - 1
#XXOO - 0034 - 2
#OXOX - 1030 - 3
#XOXO - 0204 - 4
#OXXX - 1000 - 5
#XOXX - 0200 - 6
#XXOX - 0030 - 7
#XXXO - 0004 - 8

var PresetNumber = TempNumber;

func _ready():
	pass;

func _process(deltaTime):
	
	if(timer >= 0): timer -= deltaTime;
	else:
		if(get_parent().get_parent().get_node("TouchController/SnakeHead").movingForward):
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
		2:
			SpawnBlock(3);
			SpawnBlock(4);
		3:
			SpawnBlock(1);
			SpawnBlock(3);
		4:
			SpawnBlock(2);
			SpawnBlock(4);
		5:
			SpawnBlock(1);
		6:
			SpawnBlock(2);
		7:
			SpawnBlock(3);
		8:
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
