extends Parallax2D

var set_speed : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_speed = autoscroll.x
	autoscroll.x = 0
	Utils.start_game.connect(start)
	
func start() -> void:
	var tween := create_tween()
	tween.tween_property(self, "autoscroll:x", set_speed, 1.5)
