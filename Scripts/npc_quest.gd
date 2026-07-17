extends Control

signal quest_menu_closed

var quest1_active = false
var quest1_completed = false
var onion = 0

func _process(delta: float) -> void:
	if quest1_active:
		if onion == 3:
			print("quest 1 completed")
			quest1_active = false
			quest1_completed = true
			play_finish_quest_animation()
	#if quest2_active:
			

func quest1_chat():
	$quest1_ui.visible = true
	
func next_quest():
	if !quest1_completed && !quest1_active:
		quest1_chat()
	elif quest1_completed:
		$no_quest.visible = true
		await get_tree().create_timer(3).timeout
		$no_quest.visible = false
	elif quest1_active: ###################################
		$quest_in_progress.visible = true
		await get_tree().create_timer(3).timeout
		$quest_in_progress.visible = false
	
	#elif !quest2_completed:
	

func _on_yes_button_1_pressed() -> void:
	$quest1_ui.visible = false
	quest1_active = true
	onion = 0
	emit_signal("quest_menu_closed")


func _on_no_button_1_pressed() -> void:
	$quest1_ui.visible = false
	quest1_active = false
	emit_signal("quest_menu_closed")
	
func onion_collected():
	onion += 1
	print("onion for quest")
	
func play_finish_quest_animation():
	$finished_quest.visible = true
	await get_tree().create_timer(3).timeout
	$finished_quest.visible = false
