extends CanvasLayer

var points = 0
@onready var score_number: Label = $score_number

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_number.text = str(points)


func _on_point_1_point_touched() -> void:
	points += 1
