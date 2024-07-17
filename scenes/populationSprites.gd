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

class Individual:
	func _init(genes,representation):
		self.genes=genes
		self.representation=representation
	
	var genes=[]
	var representation=null
	var score=-1
	func getScore(score):
		self.score=score
		print(self.score)
		printerr("got score")
		self.gotScore.emit(self)
	
	signal gotScore(individual:Individual)
	
func Ind_got_score(ind):
	var count=0
	for i in Individuals:
		print(i.score)
		if(i.score<0):
			count+=1
	if(count==0):
		printerr("done scoring")

var subViews=[]
func _ready():
	seed(42)
	subViews=[$GridContainer/SubViewportContainer/SubViewport,$GridContainer/SubViewportContainer2/SubViewport
	,$GridContainer/SubViewportContainer3/SubViewport,$GridContainer/SubViewportContainer4/SubViewport]
	#Individuals=[$SubViewportContainer/SubViewport/Main,$SubViewportContainer2/SubViewport/Main]
	Individuals=[]
	
	for i in range(len(subViews)):
		var m=createRandom()
		var ms=MainScene.instantiate()
		var ind=Individual.new(m,ms)
		Individuals.append(ind)
		ind.gotScore.connect(Ind_got_score)
		ms.reflexMatrix=m
		
		ms.gameover.connect(ind.getScore)
		ms.NameLabel='{'+str(i)+'}'
		subViews[i].add_child(ms)
	
	var timescale=1
	Engine.set_max_fps(timescale*initial_fps)
	Engine.set_time_scale(timescale)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

@export var initial_fps=24

func _on_h_slider_drag_ended(value_changed):
	if(!value_changed):
		return
	var value=$HSlider.value
	var timescale=value
	Engine.set_max_fps(timescale*initial_fps)
	Engine.set_time_scale(timescale)
