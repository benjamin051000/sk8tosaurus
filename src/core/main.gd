extends Node2D

@onready var main_menu: CenterContainer = $MainMenu

var level_scene = preload("res://src/levels/flat_level.tscn")
var level = level_scene.instantiate()
var skater_scene = preload("res://src/player/skater.tscn")
var skater = skater_scene.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Utils.start_game.connect(start)
	Utils.game_over.connect(game_over)

func start() -> void:
	add_child(level)

	skater.ground_path = level.get_path()
	skater.position = Vector2(397.0, 1080)
	add_child(skater)
	$Music.play()
	spawn_obstacles()

func game_over() -> void:
	print("game over")

func spawn_obstacles() -> void:
	var obstacle_scene := preload("res://src/obstacles/obstacle.tscn")
	for i in range(4, 16+1):
		var obs := obstacle_scene.instantiate()
		obs.beats_away = i
		obs.ground_path = level.get_path()
		obs.skater_path = skater.get_path()
		$Obstacles.add_child(obs)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#main_menu.queue_free()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_ESCAPE:
		get_tree().quit()
