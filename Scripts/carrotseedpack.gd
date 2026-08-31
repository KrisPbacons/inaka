extends StaticBody2D

var seed_type = 1 #carrot
var player = null

var is_in_range: bool = false
var target_object: Node2D
@onready var interact_label: Label = $Area2D/InteractLabel

func _ready() -> void:
	$AnimatedSprite2D.play("default")
		
func _physics_process(delta: float) -> void:
		pickup_object(delta)


func pickup_object(delta: float) -> void:
	global.selected = false
	if is_in_range && Input.is_action_pressed("chat") && !global.selected:
		select()
		global.plantselected = 2
		global_position  = lerp(global_position,global.player.global_position, 25 * delta)
	elif Input.is_action_just_released("chat"):
		global.plantselected = null
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	is_in_range = true
	target_object = body
	interact_label.visible = true
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	is_in_range = false
	target_object = null
	interact_label.visible = false
	
func select() -> void:
	SelectionManager.select_object(self)
	global.selected = true
	# Add visual highlight code here
	
func deselect() -> void:
	global.selected = false
	# Remove visual highlight code here
	

#ORIGINAL CODE
#func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#if Input.is_action_just_pressed("click"):
		#global.plantselected = seed_type
		#selected = true
#
#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			#selected = false
