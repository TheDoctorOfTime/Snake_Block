extends Particles2D

const MAX = 0.2

var timer = MAX;

func _process(deltaTime):
	if(emitting):
		if(timer > 0): timer -= deltaTime;
		else:
			timer = MAX;
			emitting = false;
