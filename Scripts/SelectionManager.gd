# SelectionManager.gd
extends Node

var current_selected: Node2D = null

func select_object(obj: Node2D) -> void:
	if current_selected and current_selected != obj:
		if current_selected.has_method("deselect"):
			current_selected.deselect() # Or call a custom deselect function
	current_selected = obj
