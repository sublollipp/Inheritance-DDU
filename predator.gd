extends Mover

var chasing: Node2D

func _ready() -> void:
	super._ready()

func _process(delta: float) -> void:
	if not chasePrey():
		print("COuldn't find it :(")
		randomManager(delta)
	else:
		print("FOUND THE PREY")
	super._process(delta)

func _onCollision(body: Node2D) -> void:
	body.queue_free()

func _preyEntered(body: Node2D) -> void:
	body.queue_free()
	scale.x += 1
	scale.y += 1

func chasePrey() -> bool:
	var preys = get_tree().get_nodes_in_group("Prey")
	var previousPrey
	if preys.size() > 0:
		var nearestPrey = preys[0]
		for prey in preys:
			if position.distance_to(prey.position) < position.distance_to(nearestPrey.position):
				nearestPrey = prey
			else:
				pass
		velocity = Vector2(hastighed, 0).rotated(position.angle_to_point(nearestPrey.position))
		chasing = nearestPrey
		return true
	else:
		return false
