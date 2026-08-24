extends StaticBody2D

@export var interact_name: String = ""
@export var is_interactable: bool = true
var interact: Callable = func():
	pass
@onready var interact_label: Label = $Area2D/InteractLabel
@onready var interactable: Area2D = $Area2D
var current_interactions := []
var can_interact := true

var selected
var seed_type = 2 #onion
var player = null

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	_on_interact()
	
func _on_interact():
	global.plantselected = seed_type
	selected = true
	print("Pickup")
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("chat") and can_interact:
		if current_interactions:
			can_interact = false
			interact_label.hide()
			await current_interactions[0].interact.call()
			can_interact = true
	
func _process(delta: float) -> void:
	if current_interactions and can_interact:
		current_interactions.sort_custom(_sort_by_nearest)
		if current_interactions[0].is_interactable:
			interact_label.text= current_interactions[0].interact_name
			interact_label.show()
		else:
			interact_label.hide()

func _sort_by_nearest(area1, area2):
	var area1_dist = global_position.distance_to(area1.global_position)
	var area2_dist = global_position.distance_to(area2.global_position)
	return area1_dist < area2_dist

func _on_area_2d_area_entered(area: Area2D) -> void:
	current_interactions.push_back(area)

func _on_area_2d_area_exited(area: Area2D) -> void:
	current_interactions.erase(area)


#func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int, body: Node2D) -> void:
	#player = body
	#if event.is_action_just_pressed("chat") && body.name == 'player':
		#global.plantselected = seed_type
		#selected = true
		#print("CLICKED")
		#
#func _physics_process(delta: float) -> void:
	#if selected:
		#global_position  = lerp(global_position,get_global_mouse_position(), 25 * delta)
		#
##func _input(event: InputEvent) -> void:
	##if event.is_action_just_pressed("chat"):
		##if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			##selected = false
			##print("CLICKEDDDD")
#
##func _on_area_2d_body_entered(body: Node2D) -> void:
	##player = body
	##if body.name == 'player':
		##global.plantselected = seed_type
		##selected = true
		##print("CLICKED")
