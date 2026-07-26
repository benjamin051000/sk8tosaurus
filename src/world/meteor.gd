extends Node2D

const far_scale := Vector2(0.5, 0.5)
var hp := 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween := create_tween()
	tween.tween_property(self, "scale", far_scale, 2)
	$AnimatedSprite2D.play()
	
	Utils.hit_you.connect(advance_meteor)
	Utils.game_over.connect(game_over)
	

func advance_meteor() -> void:
	hp -= 1
	if hp == 2:
		$AnimatedSprite2D.animation == "mid"
		$AnimatedSprite2D.play("mid")
	if hp <= 1:
		$AnimatedSprite2D.animation == "near"
		$AnimatedSprite2D.play("near")

func game_over():
	var tween := create_tween()
	tween.tween_property(self, "scale", Vector2(5, 5), 3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
