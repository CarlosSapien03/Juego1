extends Area2D

var speed = 100
var health = 3
var points = 100

func _ready():
    connect("area_entered", _on_area_entered)

func _process(delta):
    position.y += speed * delta
    if position.y > 500:
        queue_free()

func _on_area_entered(area):
    if area.is_in_group("bullet"):
        health -= 1
        area.queue_free()
        if health <= 0:
            emit_signal("enemy_destroyed", points)
            queue_free()

signal enemy_destroyed(points)
