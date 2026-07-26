extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var normal_texture = sprite_2d.texture

var started := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.0)


func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not started:
		started = true  # Prevents this running multiple times
		var tween := create_tween()
		tween.tween_property(self, "modulate:a", 0, 0.5)
		tween.tween_callback(queue_free)
		Utils.start_game.emit()


func _on_area_2d_mouse_entered() -> void:
	var hovered_tex := preload("res://src/ui/hover_texture.tres")
	$Sprite2D.texture = hovered_tex

func _on_area_2d_mouse_exited() -> void:
	$Sprite2D.texture = normal_texture
