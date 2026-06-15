extends StaticBody2D

var current_weather = "rain" #rain, snow, windy

func _ready() -> void:
	if current_weather == "none":
		$rain.visible = false
		$rain_colour.visible = false
	if  current_weather == "rain":
		$rain.visible = true
		$rain_colour.visible = true


func _on_timer_timeout() -> void:
	if current_weather == "none":
		current_weather = "rain"
		$Timer.wait_time = randf_range(10,20)
		$Timer.start()
	elif current_weather == "rain":
		current_weather = "none"
		$Timer.wait_time = randf_range(10,20)
		$Timer.start()
		
func _process(delta: float) -> void:
	global.weather = current_weather
	if current_weather == "none":
		$rain.visible = false
		$rain_colour.visible = false
	if  current_weather == "rain":
		$rain.visible = true
		$rain_colour.visible = true
