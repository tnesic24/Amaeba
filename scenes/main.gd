extends Node2D

func toPolarAngle(cartesian):
	var angle=cartesian.angle_to(Vector2.RIGHT)
	if(angle<0):
		angle+=2*PI
	return angle
var movementSpeedThrough=4

func _ready():
	$MobSpawnTimeout.start()
	playerPosition=$Volvox.position
	$PlayTimer.start()

@export var mob_scene: PackedScene
@export var mob_scale : float = .1
@export var paralaxBackground: ParallaxBackground
@export var speed=1

var playerPosition:Vector2;

func move(amount: Vector2):
	for e in Enemies:
		e.MoveMe(-amount)
	paralaxBackground.offsetX=-amount.x
	paralaxBackground.offsetY=-amount.y
	#$Volvox.position=playerPosition+amount*movementSpeedThrough
	


func _process(delta):
	refreshVector()
	if(Input.is_key_pressed(KEY_W)):
		move(Vector2.UP*speed)
		
	
		
	

var Enemies=[]
var inputVectorN:VectorN = VectorN.from_packed_array([0,0,0,0,0,0,0,0])
var inputVector=[0,0,0,0,0,0,0,0]
#@export reflexMatrix=[]

@export var reflexMatrix=[	randf()-.5,randf()-.5,
							randf()-.5,randf()-.5,
							randf()-.5,randf()-.5,
							randf()-.5,randf()-.5,
							randf()-.5,randf()-.5,
							randf()-.5,randf()-.5,
							randf()-.5,randf()-.5,
							randf()-.5,randf()-.5,
]

func refreshVector():
	inputVector=[0,0,0,0,0,0,0,0]
	for e in Enemies:
		var enemyOrientation: Vector2 = e.position-$Volvox.position
		var enemyMagnitude = enemyOrientation.length()
		var orientationAngle = toPolarAngle(enemyOrientation)
		
		var index = int((orientationAngle/(2*PI))*8)
		
		if(inputVector[index]==0 or inputVector[index]>enemyMagnitude):
				inputVector[int(index)]=enemyMagnitude
	var reflexMatrixN:DenseMatrix=DenseMatrix.from_packed_array(reflexMatrix,2,8)
	inputVectorN=VectorN.from_packed_array(inputVector)
	var reflexVector=reflexMatrixN.multiply_vector(inputVectorN).to_packed_array()
	var moveVector:Vector2 = Vector2(reflexVector[0],reflexVector[1]).normalized()*speed
	move(moveVector)




func _on_mob_spawn_timeout_timeout():
	var mob=mob_scene.instantiate()
	
	var mob_spawn_location=$MobPath/PathFollow2D
	mob_spawn_location.progress_ratio = randf()
	
	mob.position = mob_spawn_location.position
	mob.scale=Vector2(mob_scale,mob_scale)
	
	#var direction = mob_spawn_location.rotation + PI/2
	
	var aimat=($Volvox.position-mob.position).normalized()#.rotated(randf_range(-PI/16,PI/16))
	
	#direction += randf_range(-PI/4,PI/4)
	#mob.rotation = direction
	mob.rotation=aimat.angle()
	print(aimat.angle())
	var velocity =  randf_range(1,2)
	mob.Direction = aimat#($Volvox.position-mob_spawn_location.position).normalized().rotated(randf_range(-PI/16,PI/16))
	mob.Speed = velocity
	
	$SpawnBorder.add_child(mob)
	Enemies.append(mob)
	
	



func _on_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	print(body)
	for i in range(len(Enemies)):
		var e=Enemies[i]
		if(e==body):
			Enemies.remove_at(i)
			break
	body.queue_free()




#func _on_volvox_body_entered(body):
	#print(body)
	#print(body.position)
	#print($Volvox.position)
	#var enemyOrientation: Vector2=body.position-$Volvox.position
	#print(enemyOrientation)
	#var enemyMagnitude=enemyOrientation.length()
	#print(enemyMagnitude)
	#var orientationAngle  =toPolarAngle(enemyOrientation)
	#print(orientationAngle*(360/(PI*2)))
	#
	#var index=int((orientationAngle/(2*PI))*8)
	##print(index)
	#if(inputVector[index]==0 or inputVector[index]>enemyMagnitude):
			#inputVector[int(index)]=enemyMagnitude
			#
	##print(inputVector)


func _on_area_exited(area):
	print(area)
	for i in range(len(Enemies)):
		var e=Enemies[i]
		if(e==area):
			Enemies.remove_at(i)
			break
	area.queue_free()


func _on_volvox_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("kraj")
	score+=1-$PlayTimer.time_left
	$PlayTimer.stop()
	print(score)

@export var score=0

func _on_play_timer_timeout():
	score+=1
	print(score)
