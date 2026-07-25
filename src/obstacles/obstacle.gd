extends Node2D

## The number of beats until the obstacle reaches you and you must immediately dodge it
## (when this value reaches 0)
@export var beats_away: float = 4.0
@export var ground_path: NodePath
var ground: Node2D

const bpm := 83
const beats_per_measure := 4
var sec_per_beat := 60.0/bpm

## TODO make sure this is the same as the floor speed
var speed := -1000.0
var time_left: float

func _ready() -> void:
	var secs_away = beats_away * sec_per_beat
	position.x = secs_away * -speed + 32  # sprite offset
	ground = get_node(ground_path)
	var ground_y = ground.get_ground_height(position.x)
	position.y = ground_y - 32  # offset


func _process(delta: float) -> void:
	position.x += speed * delta
	
	if position.x + $Sprite2D.texture.get_width() / 2 < 0:
		queue_free()
