extends CanvasModulate

@export var gradient: GradientTexture1D
@export var INGAME_SPEED = 2.0
@export var INITIAL_HOUR = 10
@onready var sound = $AudioStreamPlayer2D

signal time_tick(day:int, hour:int, minute:int)
const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INAGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

var time: float = 0.0
var past_minute:float = -1.0

func _ready() -> void:
	time = INAGAME_TO_REAL_MINUTE_DURATION * MINUTES_PER_HOUR * INITIAL_HOUR 
	self.sound

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta * INAGAME_TO_REAL_MINUTE_DURATION * INGAME_SPEED
	#var value = (sin(time - 0.5 * PI) + 1.0) / 2.0 Start game at night
	var value = (sin(time) + 1.0) / 2.0 #Start game at dusk
	self.color = gradient.gradient.sample(value)
	
	_recalculate_time()
	
func _recalculate_time() -> void:
	var total_minutes = int(time / INAGAME_TO_REAL_MINUTE_DURATION)
	var day = int(total_minutes / MINUTES_PER_DAY)
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	var hour = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute = int (current_day_minutes % MINUTES_PER_HOUR)
	
	if past_minute != minute:
		past_minute = minute
		time_tick.emit(day, hour, minute)
