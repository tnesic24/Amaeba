extends Node2D

@export var Direction = [0,0]
@export var Speed=0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(Direction)
	position+=Direction*Speed

func MoveMe(amount :Vector2):
	position+=amount
