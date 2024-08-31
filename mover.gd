extends CharacterBody2D # Bedre skik at bruge en rigidbody men oh well.
class_name Mover # Definerer "Mover" som en class

@export var hastighed: int = 150 # Hastigheden skal kunne ændres syntes jeg. "Export" funktionaliteten bruges ikke stort i dette projekt

func _ready() -> void:
	velocity = Vector2(0, hastighed).rotated(deg_to_rad(randi_range(0, 359))) # Sætter velocityen til den rigtige hastighed med en random retning

var randomInterval: float = 2 # Tiden (i sekunder), før moveren skifter retning igen

var previousVelocity: Vector2 = velocity # Opbevares så man kan lave bounce mechanics

func changeDirection() -> void: # Funktionen der kører, når der skal laves et tilfældigt retningsskifte
	velocity = Vector2(0, hastighed).rotated(deg_to_rad(randi_range(0, 359))) # Igen, random retning, fast hastighed
	randomInterval = float(randi_range(3, 7)) # Ny random timer indtil næste retningsskifte

# Timer-noden er bedre skik at bruge i en situation som denne - jeg skulle bare lige skynde mig lidt, så det blev ikke til noget

func randomManager(delta): # Holder styr på randomInterval og skifter retning om nødvendigt
	randomInterval -= 1 * delta
	if randomInterval <= 0:
		changeDirection()

func _process(delta: float) -> void:
	move_and_slide() # Der er også move_and_collide(), men jeg skulle spare på godots kollisioner, da jeg overrider dem med et bounce
	
	if is_on_ceiling() or is_on_floor() or is_on_wall(): # Kører, hvis moveren rører en af væggene
		velocity = previousVelocity	 * -1 # BOUNCE (ignorer mangel på logik pls det skulle gå hurtigt)
		# previousVelocity bruges, fordi velocitien sættes til 0 af godot, når man støder klods ind i en væg
		
	previousVelocity = velocity # Opdaterer previousVelocity. MEGET VIGTIGT at dette kører EFTER alt det andet
