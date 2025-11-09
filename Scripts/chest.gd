extends StaticBody2D

@onready var Interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var coin_scene = preload("res://Scenes/Enviromentals/coin.tscn")
@export var coins_per_hit: int = 7
@export var coin_spread_angle: float = PI / 2
@export var coin_min_speed: float = 20.0
@export var coin_max_speed: float = 70.0
@onready var collision_polygon_2d_2: CollisionPolygon2D = $CollisionPolygon2D2
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D

func _ready() -> void:
	Interactable.interact = _on_interact
	collision_polygon_2d.disabled = true
	collision_polygon_2d_2.disabled = false
			
func _on_interact():
	if Interactable.player and sprite_2d.frame == 0:
		Interactable.is_interactable = false
		sprite_2d.frame = 1
		collision_polygon_2d.disabled = false
		collision_polygon_2d_2.disabled = true
		animation_player.play("open_chest")
		SoundLibrary.play_random_pickup()
		print("Chest Opened")
		for i in range(coins_per_hit):
			var instance = coin_scene.instantiate()
			instance.position = global_position
			var angle = randf_range(-coin_spread_angle/2, coin_spread_angle/2)
			var direction = Vector2(cos(angle), sin(angle))
			var speed = randf_range(coin_min_speed, coin_max_speed)
			
			if instance is RigidBody2D:
				instance.linear_velocity = direction * speed
			get_tree().current_scene.call_deferred("add_child", instance)
