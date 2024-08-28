extends Mover

@export var flugtHastighed: int = 225
@onready var rigtigFarve = $Polygon2D.color
var rigtigHastighed = hastighed


func _ready() -> void:
	super._ready()

func _process(delta: float) -> void:
	randomManager(delta)
	var predators = get_tree().get_nodes_in_group("Predator")
	if predators.size() > 0:
		var chased: bool = false
		for predator in predators:
			if predator.chasing == self:
				chased = true
		if chased:
			hastighed = flugtHastighed
			$Polygon2D.color = Color.GREEN
		else:
			hastighed = rigtigHastighed
			$Polygon2D.color = rigtigFarve
	super._process(delta)
