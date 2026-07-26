extends Node2D

@onready var main_menu: CenterContainer = $MainMenu

var level_scene := preload("res://src/levels/flat_level.tscn")
var level = level_scene.instantiate()
var skater_scene := preload("res://src/player/skater.tscn")
var skater = skater_scene.instantiate()

var meteor_scene := preload("res://src/world/meteor.tscn")
var meteor := meteor_scene.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Utils.start_game.connect(start)
	Utils.game_over.connect(game_over)

func start() -> void:
	add_child(meteor)
	#await get_tree().create_timer(1).timeout
	
	add_child(level)

	skater.ground_path = level.get_path()
	skater.position = Vector2(397.0, 1080)
	add_child(skater)
	$Music.play()
	spawn_obstacles()

func game_over() -> void:
	$GameOver.visible = true
	$LoseSound.play(1.75)

var obstacle_scene := preload("res://src/obstacles/obstacle.tscn")
func _spawn(beats_away) -> void:
	var obs := obstacle_scene.instantiate()
	obs.beats_away = beats_away
	obs.ground_path = level.get_path()
	obs.skater_path = skater.get_path()
	$Obstacles.add_child(obs)

func spawn_obstacles() -> void:
	# Intro, stops right at guitar intro
	for i in range(4, 16+1, 2):
		_spawn(i)

	for i in range(17, 32):
		_spawn(i)
	
	var notes := [32, 33, 35, 36, 37, 39, 40, 41, 43, 44, 45, 47]
	for note in notes:
		_spawn(note)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()
		elif event.keycode == KEY_R:
			$RoarSound.play()
	
