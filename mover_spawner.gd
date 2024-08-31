extends Node

# Preloader scenerne for henholdsvist predator og prey
@onready var predatorScene: PackedScene = preload("res://predator.tscn")
@onready var preyScene: PackedScene = preload("res://prey.tscn")

func _input(event: InputEvent) -> void: # Denne funktion kører, når der bliver trykket på et input.
	#event.is_action_pressed() gældeer kun, når der lige er blevet trykket - så at holde knappen inde gør intet i dette tilfælde
	if event.is_action_pressed("SPAWNPREDATOR"): # Checker, om inputtet er "SPAWNPREDATOR" (defineret i Project Settings -> Input Map
		var predator: Node2D = predatorScene.instantiate() # Forbereder en instance af predator. Tænk på scenen som en class og instancen som et objekt.
		predator.position = get_viewport().get_mouse_position() # Sætter dens position til musens position
		var størrelse: float = randf_range(3, 5) # Giver den en tilfældig float størrelse mellem 3 og 5
		predator.scale = Vector2(størrelse, størrelse) # Størrelsen sættes til dens indbyggede "scale" værdi på både X og Y.
		add_child(predator) # Tilføjer den nye node som et child af denne
	if event.is_action_pressed("SPAWNPREY"):
		# Hele denne sektion er det samme som ovenover, bare med prey
		var prey: Node2D = preyScene.instantiate()
		var størrelse = randf_range(3, 5)
		prey.scale = Vector2(størrelse, størrelse)
		prey.position = get_viewport().get_mouse_position()
		add_child(prey)
