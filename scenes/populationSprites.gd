extends Node2D

@export var Individuals:Array
@export var MainScene: PackedScene
# Called when the node enters the scene tree for the first time.

func createRandom():
	var reflexMatrix=[		randf()-.5,randf()-.5,
							randf()-.5,randf()-.5,
							randf()-.5,randf()-.5,
							randf()-.5,randf()-.5,
							randf()-.5,randf()-.5,
							randf()-.5,randf()-.5,
							randf()-.5,randf()-.5,
							randf()-.5,randf()-.5,
	]
	return reflexMatrix

func createForDebug(i):
	var reflexMatrix=[		i-.5,i-.5,
							i-.5,i-.5,
							i-.5,i-.5,
							i-.5,i-.5,
							i-.5,i-.5,
							i-.5,i-.5,
							i-.5,i-.5,
							i-.5,i-.5,
	]
	return reflexMatrix
	
var subViews=[]
func _ready():
	seed(42)
	subViews=[$GridContainer/SubViewportContainer/SubViewport,$GridContainer/SubViewportContainer2/SubViewport
	,$GridContainer/SubViewportContainer3/SubViewport,$GridContainer/SubViewportContainer4/SubViewport]
	#Individuals=[$SubViewportContainer/SubViewport/Main,$SubViewportContainer2/SubViewport/Main]
	Individuals=[]
	for i in range(len(subViews)):
		Individuals.append(createRandom())
	
	for i in range(len(subViews)):
		var ms=MainScene.instantiate()
		ms.reflexMatrix=Individuals[i]
		subViews[i].add_child(ms)
	
	var timescale=2
	var initial_fps=24
	Engine.set_max_fps(timescale*initial_fps)
	Engine.set_time_scale(timescale)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
