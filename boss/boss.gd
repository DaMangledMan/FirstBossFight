extends Area2D

signal dead



@export var health = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if health == 0:
		dead.emit()


func start(pos):
	position = pos
	health = 2000

func edit_health(new_health):
	health = new_health

func add_to_health(add):
	health += add

func boss_living():
	if health != 0:
		return true
	else:
		return false
