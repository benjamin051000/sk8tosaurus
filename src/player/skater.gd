extends Area2D

@export var jump_height: float = 130.0
@export var rise_time: float = 0.1
@export var hang_time: float = 0.25
@export var fall_time: float = 0.1

var tween: Tween

func jump() -> void:
	if tween and tween.is_running():
		return  # already jumping, ignore

	var ground_y := position.y
	
	tween = create_tween()
	
	tween.tween_property(self, "position:y", ground_y - jump_height, rise_time) \
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_interval(hang_time)
	
	tween.tween_property(self, "position:y", ground_y, fall_time) \
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)


func _physics_process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		jump()
