extends Mover

# Hastigheden, som prey får, når det flygter
@export var flugtHastighed: int = 450
# Farven, som prey får, når det flygter
@export var flugtFarve: Color = Color.GREEN
# Preyets oprindelige farve. Gemmes, så man kan skifte tilbage til det.
@onready var rigtigFarve = $Polygon2D.color
# Prey inheriter hastighed fra mover. Den oprindelige hastighed gemmes, så man kan skifte tilbage, hvis et prey stopper med at blive jegtet
var rigtigHastighed = hastighed

# Man behøver sådan set ikke at skrive en ready funktion - den er her bare for læsbarhedens skyld
func _ready() -> void:
	super._ready()

func _process(delta: float) -> void:
	# Bevæger sig randomly. Inheriter funktionen fra mover
	randomManager(delta)
	# Får et array af alle predators der er i spillet.
	var predators = get_tree().get_nodes_in_group("Predator")
	# Kører, hvis der er mindst 1 predator i spillet
	if predators.size() > 0:
		# Checker, om dette prey bliver chased
		var chased: bool = false
		# Går igennem arrayet af predators
		for predator in predators:
			# Predators chasing variabel er en prey node. Checker om denne node svarer til dette prey (hvilket vil sige, at predatoren jagter dette prey)
			if predator.chasing == self:
				chased = true
				# For-loopet behøver ikke køre længere nu. Der er ingen forskel på, om der er 1 eller 1000 predators efter den.
				break
		# Sætter hatigheden hurtigere og ændrer farven, hvis den bliver ændret
		if chased:
			hastighed = flugtHastighed
			$Polygon2D.color = flugtFarve
		else:
			# Resetter hastighed og farve hvis den ikke jagtes længere
			hastighed = rigtigHastighed
			$Polygon2D.color = rigtigFarve
		# Sørger t opdatere bevægelsesvektorens hastighed (som ellers kun opdateres, når noden skifter retning)
		velocity = velocity.normalized() * hastighed
	super._process(delta) # Kører superklassens process funktion
