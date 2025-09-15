extends Node2D

var hitCount = 0

@export var escalatorScene: PackedScene
var escalator

func _ready() -> void:
	escalator = escalatorScene.instantiate()
	escalator.position = Vector2(500,10);
	add_child(escalator);
	
	escalator.connect("beenHit",_on_escalator_been_hit)

func _on_escalator_been_hit() -> void:
	hitCount += 1
	$CanvasLayer/Label.text = "Hit Count: " + str(hitCount)
	#escalator.queue_free()
