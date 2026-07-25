extends Area2D

@export var jump_height: float = 130.0
@export var rise_time: float = 0.1
@export var hang_time: float = 0.25
@export var fall_time: float = 0.1

var tween: Tween
var jumping := false

func jump() -> void:
	jumping = true
	if tween and tween.is_running():
		return  # already jumping, ignore

	$SkateSound.stop()
	$Push1.stop()
	$Push2.stop()
	$PushSoundTimer.paused = true
	var ground_y := position.y
	
	tween = create_tween()
	
	tween.tween_property(self, "position:y", ground_y - jump_height, rise_time) \
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_interval(hang_time)
	
	tween.tween_property(self, "position:y", ground_y, fall_time) \
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_callback($SkateSound.play)
	tween.tween_callback(func(): $PushSoundTimer.paused = false)


func _physics_process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		jump()

func _on_push_sound_timer_timeout() -> void:
	var sounds = [$Push1, $Push2]
	# TODO vary the pitch and volume?
	sounds.pick_random().play()
	# Vary the timer a bit
	$PushSoundTimer.wait_time = randf_range(1.0, 3.0)
