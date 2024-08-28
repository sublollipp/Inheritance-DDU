extends Node

@onready var predatorScene: PackedScene = preload("res://predator.tscn")
@onready var preyScene: PackedScene = preload("res://prey.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("SPAWNPREDATOR"):
		var predator = predatorScene.instantiate()
		predator.position = get_viewport().get_mouse_position()
		var størrelse = randf_range(3, 5)
		predator.scale = Vector2(størrelse, størrelse)
		get_parent().get_node("Predators").add_child(predator)
	if event.is_action_pressed("SPAWNPREY"):
		var prey = preyScene.instantiate()
		var størrelse = randf_range(3, 5)
		prey.scale = Vector2(størrelse, størrelse)
		prey.position = get_viewport().get_mouse_position()
		get_parent().get_node("Preys").add_child(prey)
