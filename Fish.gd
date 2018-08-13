extends Area2D

export (int) var speed
export (int) var maxDistance 

var xDir = 1
var yDir = 1
var screensize
var targetLocation

func _ready():
	screensize = get_viewport_rect().size
	targetLocation = chooseLocation()
	$TargetTimer.start()
	pass

func _process(delta):
	var velocity = Vector2()
	
	var posX = cos(targetLocation[0]) * targetLocation[1]
	var posY = sin(targetLocation[0]) * targetLocation[1]
	
	velocity.x += xDir * posX
	velocity.y += yDir * posY
	
	velocity = velocity.normalized() * speed
	position += velocity * delta
	
	if targetLocation[0] >=  PI / 2 && targetLocation[0] <= 3 * PI / 2:
		rotation = targetLocation[0] + PI
		$Sprite.flip_h = true
	else :
		rotation = targetLocation[0]
		$Sprite.flip_h = false

# Creates a location
func chooseLocation():
	var distance = randi() % maxDistance
	var angle = rand_range(0, 2 * PI)
	print (angle)
	print (distance)
	return [angle, distance]

func _on_VisibilityNotifier2D_screen_exited():
	if position.x < 0 || position.x > screensize.x:
		xDir *= -1;
	if position.y < 0 || position.y > screensize.y:
		yDir *= -1;

func _on_new_target_timeout():
	targetLocation = chooseLocation()
