extends CharacterBody2D

signal onion_collected
signal apple_collected
signal slime_collected

@export var inv: Inv

enum State {IDLE, MOVE}
var current_state = State.IDLE

const SPEED = 19000.0
var direction : Vector2
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	handle_state_transitions()
	perform_state_actions(delta)
	move_and_slide()

func handle_state_transitions():
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
		current_state = State.MOVE
	else:
		current_state = State.IDLE
	
func perform_state_actions(delta):
	match current_state:
		State.MOVE:
			direction.x = Input.get_axis("ui_left", "ui_right")
			direction.y = Input.get_axis("ui_up", "ui_down")
			direction = direction.normalized()
			
			if direction.x < 0 && direction.y == 0:
				animated_sprite_2d.animation = "walk_left" #walk left
			if direction.x > 0 && direction.y == 0:
				animated_sprite_2d.animation = "walk_right"
			if direction.y < 0:
				animated_sprite_2d.animation = "walk_up"
			if direction.y > 0:
				animated_sprite_2d.animation = "walk_down"
				
			velocity = direction * SPEED * delta
			
		State.IDLE:
			velocity = Vector2(0,0)
		
			if animated_sprite_2d.animation == "walk_left":
				animated_sprite_2d.animation = "idle"
			if animated_sprite_2d.animation == "walk_right":
				animated_sprite_2d.animation = "idle"
			if animated_sprite_2d.animation == "walk_up":
				animated_sprite_2d.animation = "idle"
			if animated_sprite_2d.animation == "walk_down":
				animated_sprite_2d.animation = "idle"
	
func player():
	pass
	
func collect(item):
	inv.insert(item)
	print(item)
	if str(item) == "(res://Inventory/Items/onion.tres):<Resource#-9223371991237523776>": #onion
		print("picked up onion")
		emit_signal("onion_collected")
	elif str(item) == "(res://Inventory/Items/apple.tres):<Resource#-9223371997327653271>": #apple
		print("picked up apple")
		emit_signal("apple_collected")
	#if str(item) == "(res://Inventory/Items/apple.tres):<Resource#-9223371997327653271>": #slime
		#print("picked up apple")
		#emit_signal("apple_collected")
		
