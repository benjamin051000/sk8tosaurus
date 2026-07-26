extends Area2D

@export var jump_height: float = 100.0
@export var rise_time: float = 0.1
@export var hang_time: float = 0.20
@export var fall_time: float = 0.1

@export var health := 3

func health_to_str() -> String:
	return str(health) + " HP"

@export var ground_path: NodePath
var ground: Node2D

## Manually measured, since the sprite texture is not cropped and the
## bottom has a little transparent border.
const feet_y_offset := 160.0
## Manually measured
const front_x_offset := 115.0

var tween: Tween
var jumping := false
var dead := false

func got_hit() -> void:
	if dead:
		return
	health -= 1
	$HealthLabel.text = health_to_str()
	if health == 0:
		Utils.game_over.emit()
		$Sprite2D.queue_free()
		$HealthLabel.queue_free()
		dead = true

func _ready() -> void:
	ground = get_node(ground_path)
	Utils.hit_you.connect(got_hit)
	$HealthLabel.text = health_to_str()
	$Skateboard.play()
	
func _process(_delta: float) -> void:
	if not jumping:
		var ground_y = ground.get_ground_height(position.x)
		position.y = ground_y - feet_y_offset
		# TODO the lerp smooths it out too much
		#position.y = lerp(position.y, ground_y - feet_y_offset, _delta * 0.99)

func jump() -> void:
	jumping = true
	if tween and tween.is_running():
		return  # already jumping, ignore

	$SkateSound.stop()
	$Push1.stop()
	$Push2.stop()
	$PushSoundTimer.paused = true
	$JumpSound.play()
	var ground_y := position.y
	
	tween = create_tween()
	
	tween.tween_property(self, "position:y", ground_y - jump_height, rise_time) \
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_interval(hang_time)
	
	tween.tween_property(self, "position:y", ground_y, fall_time) \
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_callback(play_random_land_sound)
	tween.tween_callback($SkateSound.play)
	tween.tween_callback(func(): $PushSoundTimer.paused = false; jumping = false)


func _physics_process(_delta: float) -> void:
	# HACK: Don't jump if we just started emerging from the ground on new game.
	if position.y > 900:
		return
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		jump()

func play_random_land_sound() -> void:
	var sounds = [$LandSound1, $LandSound2, $LandSound3, $LandSound4, $LandSound5]
	sounds.pick_random().play()

func _on_push_sound_timer_timeout() -> void:
	var sounds = [$Push1, $Push2]
	# TODO vary the pitch and volume?
	sounds.pick_random().play()
	# Vary the timer a bit
	$PushSoundTimer.wait_time = randf_range(1.0, 3.0)
