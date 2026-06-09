extends Area2D

signal point_touched
@onready var point_item_audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var light: PointLight2D = $PointLight2D

func _ready() -> void:
	var tween = create_tween().set_loops()
	tween.tween_property(self, "position", position + Vector2(0,-2), 1)
	tween.tween_property(self, "position", position + Vector2(0,2), 1)

func _on_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		var tween = create_tween()
		
		point_item_audio.play()
		point_touched.emit()
		
		tween.set_parallel(true)
		tween.tween_property(self, "position", position + Vector2(0,-10), 0.3)
		tween.tween_property(self, "modulate:a",0.0, 0.3)
		tween.tween_property(light, "energy",0.0, 0.2)
		tween.chain().tween_callback(self.queue_free)
