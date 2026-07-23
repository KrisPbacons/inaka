extends StaticBody2D

var state = "day" # day night
var change_state = false
var length_of_day = 8 #secs
var length_of_night = 8


func _ready() -> void:
	if state == "day":
		$ColorRect.color.a = 0
	elif state == "night":
		$ColorRect.color.a = 150

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if change_state == true:
		change_state = false
		if state == "day":
			change_to_day()
		if state == "night":
			change_to_night()




func _on_timer_timeout() -> void:
	if state == "day":
		state = "night"
	elif state == "night":
		state = "day"
	
	change_state = true

func change_to_day():
	$AnimationPlayer.play("nighttoday")
	$Timer.wait_time = length_of_day
	$Timer.start()
	
func change_to_night():
	$AnimationPlayer.play("daytonight")
	$Timer.wait_time = length_of_day
	$Timer.start()
