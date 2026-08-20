extends MarginContainer

@export var menu_screen: VBoxContainer
@export var open_menu_screen: VBoxContainer
@export var help_menu_screen: MarginContainer
@export var settings_menu_screen: MarginContainer
@export var audio_bus_name: String
var audio_bus_id

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	#visible = false
	get_tree().paused = false
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Menu") && !get_tree().paused:
		pause()
		toggle_visibility(menu_screen)
		toggle_visibility(open_menu_screen)
	elif Input.is_action_just_pressed("Menu") && get_tree().paused:
		resume()
		menu_screen.visible = false
		open_menu_screen.visible = false
		help_menu_screen.visible = false
		settings_menu_screen.visible = false

	
func toggle_visibility(object):
	if object.visible:
		object.visible = false
	else:
		object.visible = true
		

#func _on_toggle_menu_button_pressed():
	#toggle_visibility(menu_screen)
	#toggle_visibility(open_menu_screen)


func _on_toggle_help_menu_button_pressed() -> void:
	toggle_visibility(help_menu_screen)
	toggle_visibility(menu_screen)


func _on_toggle_exit_menu_button_pressed() -> void:
	toggle_visibility(settings_menu_screen)
	toggle_visibility(menu_screen)


func _on_settings_button_pressed() -> void:
	toggle_visibility(settings_menu_screen)
	toggle_visibility(menu_screen)

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")


func _on_h_scroll_bar_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)


func _on_h_scroll_bar_2_value_changed(value: float) -> void:
	WorldEnvironmentGlobal.environment.adjustment_brightness = value

func _on_quit_button_2_pressed() -> void:
	$baseMenuScreenContainer/baseMenuScreen/VBoxContainer/NinePatchRect/MarginContainer/ConfirmationDialog.visible = true
	
func _on_confirmation_dialog_confirmed() -> void:
	get_tree().quit()
	
func _notification(what) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("The X button was clicked!")
		get_tree().quit() 
		
