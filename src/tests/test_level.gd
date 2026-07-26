extends Node2D

@onready var skater: Area2D = $Skater
@onready var flat_level: Node2D = $FlatLevel

@onready var back_clouds: Parallax2D = $"Back clouds"
@onready var front_clouds: Parallax2D = $"Front Clouds"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back_clouds.autoscroll.x = -300
	front_clouds.autoscroll.x = -600


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
