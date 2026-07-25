extends Node2D

@export var scroll_speed_x := -1000.0
@onready var a: Sprite2D = $GroundA
@onready var b: Sprite2D = $GroundB

var screen_width : float
var sprite_width : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_width = get_viewport_rect().size.x
	assert(a.texture.get_size() == b.texture.get_size())
	sprite_width = a.texture.get_width() * a.scale.x
	assert(is_equal_approx(screen_width, sprite_width))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dx = scroll_speed_x * delta
	a.position.x += dx
	b.position.x += dx

	warp_sprite(a, b)
	warp_sprite(b, a)

func warp_sprite(l: Sprite2D, r: Sprite2D) -> void:
	if l.position.x + sprite_width < 0:
		l.position.x = r.position.x + sprite_width
