extends Node2D

const far_scale := Vector2(0.5, 0.5)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween := create_tween()
	tween.tween_property(self, "scale", far_scale, 2)
	$AnimatedSprite2D.play()
	
	Utils.hit_you.connect(advance_meteor)
	

func advance_meteor() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
