extends CharacterBody2D

const speed = 190
var current_state = IDLE
enum {IDLE, NEW_DIR, MOVE}
var is_roaming = true
var is_chatting = false
var player 
var player_in_chat_zone = false
var dir = Vector2.RIGHT
var start_pos

func _ready() -> void:
	randomize()
	start_pos = position

func _process(delta: float) -> void:
	if global.weather == "rain":
		$AnimatedSprite2D.visible = false
		is_roaming = false
	else:
		$AnimatedSprite2D.visible = true
		is_roaming = true
		
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("idle")
	elif current_state == 2 and !is_chatting:
		if dir.x == -1:
			$AnimatedSprite2D.play("walk_left")
		if dir.x == 1:
			$AnimatedSprite2D.play("walk_right")
		if dir.y == -1:
			$AnimatedSprite2D.play("walk_up")
		if dir.y == 1:
			$AnimatedSprite2D.play("walk_down")
			
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			MOVE:
				move(delta)
	if Input.is_action_just_pressed("chat") && player_in_chat_zone && !is_chatting:
		print("Chatting with NPC")
		$dialogue.start()
		is_roaming = false
		is_chatting = true
		$AnimatedSprite2D.play("idle")
				
func choose(array):
	array.shuffle()
	return array.front()
func move(delta):
	if !is_chatting:
		position += dir * speed * delta

func _on_chat_detection_area_body_entered(body: Node2D) -> void:
	#if body.has_method("player"):
	if body.is_in_group("player"):
		player = body
		player_in_chat_zone = true

func _on_chat_detection_area_body_exited(body: Node2D) -> void:
	#if body.has_method("player"):
	if body.is_in_group("player"):
		player_in_chat_zone = false


func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])

func _on_dialogue_dialogue_finished() -> void:
	is_chatting = false
	is_roaming = true
