extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Utils.start_game.connect(start_game)

func start_game():
	var tween := create_tween()
	tween.tween_interval(0.5)
	tween.tween_property(self, "modulate:a", 1.0, 1.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
