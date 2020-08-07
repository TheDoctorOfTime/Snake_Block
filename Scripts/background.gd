extends TextureRect

export(float) var scrollSpeed = -0.07;

func _ready():
	material.set_shader_param("scroll_speed", scrollSpeed);
