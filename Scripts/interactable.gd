extends Area2D

@export var interact_name: String = ""
@export var is_interactable: bool = true
@onready var player = get_tree().get_root().find_child("Player", true, false)
@onready var sprite: Sprite2D = get_parent().get_node_or_null("Sprite2D")

var interact: Callable = func(): pass

func set_highlighted(state: bool) -> void:
	if sprite and sprite.material:
		sprite.material.set_shader_parameter("outline_enabled", state)
