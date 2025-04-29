extends Area2D

var speed = 500

func _ready():
    add_to_group("bullet")

func _process(delta):
    position.y -= speed * delta
    if position.y < -20:
        queue_free()
