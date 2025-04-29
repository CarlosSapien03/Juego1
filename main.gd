extends Node2D

var player_scene = preload("res://player.tscn")
var enemy_scene = preload("res://enemy.tscn")
var bullet_scene = preload("res://bullet.tscn")

var score = 0
var enemies_destroyed = 0
var game_over = false

func _ready():
    $EnemySpawner.start()
    update_score()

func update_score():
    $UI/ScoreLabel.text = "Puntos: %d" % score

func spawn_enemy():
    if game_over:
        return
    
    var enemy = enemy_scene.instantiate()
    add_child(enemy)
    enemy.position = Vector2(
        randf_range(50, 590),
        randf_range(-50, -20)
    )
    enemy.connect("enemy_destroyed", _on_enemy_destroyed)

func _on_enemy_destroyed(points):
    score += points
    enemies_destroyed += 1
    update_score()
    
    if enemies_destroyed >= 20:
        $UI/GameOverLabel.text = "¡Nivel completado!"
        $UI/GameOverLabel.visible = true
        game_over = true
        $EnemySpawner.stop()

func _on_enemy_spawner_timeout():
    spawn_enemy()
