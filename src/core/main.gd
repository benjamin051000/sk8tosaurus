extends Node2D

@onready var main_menu: CenterContainer = $MainMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Utils.start_game.connect(start)

func start() -> void:
	var level = preload("res://src/levels/flat_level.tscn")
	add_child(level.instantiate())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#main_menu.queue_free()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_ESCAPE:
		get_tree().quit()
