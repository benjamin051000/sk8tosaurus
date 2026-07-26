extends Node2D

@onready var main_menu: CenterContainer = $MainMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Utils.start_game.connect(start)

func start() -> void:
	var level_scene = preload("res://src/levels/flat_level.tscn")
	var level = level_scene.instantiate()
	add_child(level)
	var skater_scene = preload("res://src/player/skater.tscn")
	var skater = skater_scene.instantiate()
	skater.ground_path = level.get_path()
	skater.position = Vector2(397.0, 1080)
	add_child(skater)
	$Music.play()
	# TODO start shooting obstacles?
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#main_menu.queue_free()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_ESCAPE:
		get_tree().quit()
