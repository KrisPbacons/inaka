extends CharacterBody2D

var eating = false
var walking = false
var xdir = 1 #1 = right -1 = left
var ydir = 1 #1 = down -1 = up
var speed = 15000
var motion : Vector2
var moving_vertical_horizontal = 1 #1 = horizontal 2 = vertical

func _ready() -> void:
	walking = true
	randomize()
	
func _physics_process(_delta):
	var waittime = 1
	if walking == false:
		var x = randi_range(1,2)
		if x > 1.5:
			moving_vertical_horizontal = 1
		else:
			moving_vertical_horizontal = 2
	
	if walking == true:
		$AnimatedSprite2D.play("walk")
		if moving_vertical_horizontal == 1:
			if xdir == -1:
				$AnimatedSprite2D.flip_h = true
				motion.x = -speed 
				motion.y = 0
			if xdir == 1:
				$AnimatedSprite2D.flip_h = false
				motion.x = speed 
				motion.y = 0
			
		elif moving_vertical_horizontal == 2:
			if ydir == -1:
				motion.y = -speed 
				motion.x = 0
			if ydir == 1:
				motion.y = speed
				motion.x = 0
				
	if eating == true:
		$AnimatedSprite2D.play("eating")
		#motion.y = 0
		#motion.x = 0
		motion = Vector2.ZERO
	velocity = motion * _delta
	move_and_slide()

func _on_change_state_timeout() -> void:
	var waittime = 1
	if walking == true:
		eating = true
		walking = false
		waittime = randi_range(1,5)
	elif eating == true:
		walking = true
		eating = false
		waittime = randi_range(2,6)
	$"change state".wait_time = waittime
	$"change state".start()
		

func _on_walking_timeout() -> void:
	var x = randi_range(1,2)
	var y = randi_range(1,2)
	var waittime = randi_range(1,4)
	
	if x > 1.5:
		xdir = 1 #right
	else:
		xdir = -1 #left
	if y > 1.5:
		ydir = 1 #up
	else:
		ydir = -1 #down
	$"walking".wait_time = waittime
	$"walking".start()
	
	
	
	
	
	
	
	
	
	
	
	
