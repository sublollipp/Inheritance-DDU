extends CharacterBody2D
class_name Mover

@export var hastighed: int = 150

func _ready() -> void:
	velocity = Vector2(0, hastighed)

var randomInterval: float = 2

var previousVelocity: Vector2 = velocity

func changeDirection() -> void:
	velocity = Vector2(0, hastighed).rotated(deg_to_rad(randi_range(0, 360)))
	randomInterval = float(randi_range(3, 7))

func randomManager(delta):
	randomInterval -= 1 * delta
	if randomInterval <= 0:
		changeDirection()

func _process(delta: float) -> void:
	move_and_slide()
	
	if is_on_ceiling() or is_on_floor() or is_on_wall():
		velocity = previousVelocity	 * -1
		
	previousVelocity = velocity
