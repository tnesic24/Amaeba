extends Node2D

func toPolarAngle(cartesian):
	var angle=cartesian.angle_to(Vector2.RIGHT)
	if(angle<0):
		angle+=2*PI
	return angle

# Called when the node enters the scene tree for the first time.
func _ready():
	$MobSpawnTimeout.start()

@export var mob_scene: PackedScene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#$Volvox/CollisionShape2D2.

	
var inputVector=[0,0,0,0,0,0,0,0]

var speed=0.1

func _on_volvox_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print(area)
	print(area.position)
	print($Volvox.position)
	var enemyOrientation: Vector2=area.position-$Volvox.position
	print(enemyOrientation)
	var enemyMagnitude=enemyOrientation.length()
	print(enemyMagnitude)
	var orientationAngle  =toPolarAngle(enemyOrientation)
	print(orientationAngle*(360/(PI*2)))
	
	var index=int((orientationAngle/(2*PI))*8)
	print(index)
	if(inputVector[index]==0 or inputVector[index]>enemyMagnitude):
			inputVector[int(index)]=enemyMagnitude
			
	print(inputVector)
	pass # Replace with function body.


func _on_mob_spawn_timeout_timeout():
	var mob=mob_scene.instantiate()
	
	var mob_spawn_location=$MobPath/PathFollow2D
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI/2
	
	mob.position = mob_spawn_location.position
	
	direction += randf_range(-PI/4,PI/4)
	mob.rotation = direction
	
	var velocity =  Vector2(randf_range(150.0,250.0),0.0)
	mob.linear_velocity = -velocity.rotated(direction)
	
	add_child(mob)
	
	for i in self.get_children():
		print(i)
	



func _on_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	print(body)
	body.queue_free()

	for i in self.get_children():
		print(i)


func _on_volvox_body_entered(body):
	print(body)
	print(body.position)
	print($Volvox.position)
	var enemyOrientation: Vector2=body.position-$Volvox.position
	print(enemyOrientation)
	var enemyMagnitude=enemyOrientation.length()
	print(enemyMagnitude)
	var orientationAngle  =toPolarAngle(enemyOrientation)
	print(orientationAngle*(360/(PI*2)))
	
	var index=int((orientationAngle/(2*PI))*8)
	print(index)
	if(inputVector[index]==0 or inputVector[index]>enemyMagnitude):
			inputVector[int(index)]=enemyMagnitude
			
	print(inputVector)
