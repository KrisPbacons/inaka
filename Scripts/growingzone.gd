extends StaticBody2D

var plant = global.plantselected
var plantgrowing = false
var plant_grown = false

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	if !plantgrowing:
		plant = global.plantselected
		

func _on_area_2d_area_entered(area: Area2D) -> void:
	if !plantgrowing:
		if plant == 1:
			plantgrowing = true
			$carrotgrowtimer.start()
			$plant.play("carrotgrowing")
		if plant == 2:
			plantgrowing = true
			$oniongrowtimer.start()
			$plant.play("oniongrowing")
		else:
			print("plant already growing")
			
func _on_carrotgrowtimer_timeout() -> void:
	var carrot_plant = $plant
	if carrot_plant.frame == 0:
		carrot_plant.frame = 1
		$carrotgrowtimer.start()
	elif carrot_plant.frame == 1:
		carrot_plant.frame = 2
		plant_grown = true

func _on_oniongrowtimer_timeout() -> void:
	var onion_plant = $plant
	if onion_plant.frame == 0:
		onion_plant.frame = 1
		$oniongrowtimer.start()
	elif onion_plant.frame == 1:
		onion_plant.frame = 2
		plant_grown = true


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		if plant_grown == true:
			if plant == 1:
				global.numofcarrots += 1
				plantgrowing = false
				plant_grown = false
				$plant.play("none")
			elif plant == 2:
				global.numofonions += 1
				plantgrowing = false
				plant_grown = false
				$plant.play("none")
			else:
				pass
		print(global.numofcarrots)
		print(global.numofonions)
