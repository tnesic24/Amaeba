extends ParallaxBackground

@export var offsetX=0
@export var offsetY=0

func _process(delta):
	scroll_base_offset.x+=offsetX
	scroll_base_offset.y+=offsetY
