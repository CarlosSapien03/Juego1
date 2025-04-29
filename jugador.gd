extends Area2D

var speed = 300
var can_shoot = true
var bullet_cooldown = 0.3

func _process(delta):
    var input = Vector2.ZERO
    
    if Input.is_action_pressed("ui_right"):
        input.x += 1
    if Input.is_action_pressed("ui_left"):
        input.x -= 1
    if Input.is_action_pressed("ui_down"):
        input.y += 1
    if Input.is_action_pressed("ui_up"):
        input.y -= 1
        
    position += input.normalized() * speed * delta
    position.x = clamp(position.x, 20, 620)
    position.y = clamp(position.y, 20, 460)
    
    if Input.is_action_pressed("ui_accept") and can_shoot:
        shoot()
        can_shoot = false
        get_tree().create_timer(bullet_cooldown).timeout.connect(func(): can_shoot = true)

func shoot():
    var bullet = preload("res://bullet.tscn").instantiate()
    bullet.position = position + Vector2(0, -20)
    get_parent().add_child(bullet)
