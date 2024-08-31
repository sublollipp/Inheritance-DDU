extends Mover

# Chasing er den prey, som denne predator er i gang med at jagte
var chasing: Node2D

# Man behøver ikke have en ready funktion her overhovedet. Er her kun for læsbarhedens skyld
func _ready() -> void:
	super._ready()

func _process(delta: float) -> void:
	# Kører chasePrey() funktionen. Hvis den ikke kan finde et prey, så bevæger den sig tilfældigt
	if not chasePrey():
		randomManager(delta)
	super._process(delta)

func _preyEntered(body: Node2D) -> void: # Denne er hooket op til en Area2D, der kun registrerer collisions med preys
	body.queue_free() # "body" er den node, Area2D'en er kollideret med. queue_free() sletter den
	# Øger predatorens størrelse
	scale.x += 1
	scale.y += 1

func chasePrey() -> bool: # Denne funktion står for at finde- og jagte prey
	var preys = get_tree().get_nodes_in_group("Prey") # Skaffer alle preys som et array
	if preys.size() > 0: # Kører kun nedenstående, hvis der overhovedet er et prey
		var nearestPrey = preys[0] # For-loopet sammenligner, hvor tæt på alting er - den skal have en baseline
		for prey in preys: # Enhanced for-loop. "prey" repræsenterer en prey node i "Prey" gruppen
			if position.distance_to(prey.position) < position.distance_to(nearestPrey.position): # Sammenligner afstand fra den hidtil tætteste prey og den nuværende
				nearestPrey = prey # Hvis denne prey er tættere på end den før, er denne prey nu tættest på
			else: # Ved ikke helt, hvorfor jeg beholdt else statemented. Måske readability?
				pass
		# Velocity er en indbygget variabel i Node2D (og mange andre nodes), der lægges til positionen i hver frame
		velocity = Vector2(hastighed, 0).rotated(position.angle_to_point(nearestPrey.position))
		chasing = nearestPrey # "chasing" repræsenterer det prey, der lige nu jagtes. Opbevares så prey ved, om det bliver jagtet
		return true
	else:
		return false # Kig i _process. Hvis den returner false, er det fordi, der er 0 preys, og så bliver den tilfældig
