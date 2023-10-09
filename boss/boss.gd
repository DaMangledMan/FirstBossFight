extends Area2D

signal dead

@export var health = 0
@export var _speed = 100
@export var is_alive = false
@export var acting = false
@export var attack_type = "light"
@export var last_direction = "right"
var velocity
var max = Vector2.ZERO
var player_position = Vector2.ZERO



# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "idle_up"
	$AnimatedSprite2D.play()
	max.x += 2000
	max.y += 2000


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if health == 0:
		dead.emit()
		velocity = Vector2.ZERO
		is_alive = false
	
	if !acting and is_alive:
		
		velocity = Vector2.ZERO
		velocity.x = -(position.x - player_position.x)
		velocity.y = -(position.y - player_position.y)
		velocity = velocity.normalized() * _speed
	
	
	
	# controls the movement on a perframe basis
	position += velocity * delta
	# prevents player from leaving the screen
	position = position.clamp(Vector2.ZERO, max)


func start(pos):
	position = pos
	health = 2000
	is_alive = true

func edit_health(new_health):
	health = new_health

func add_to_health(add):
	health += add

func get_player_position(position):
	player_position.x = position.x
	player_position.y = position.y

func boss_living():
	if health != 0:
		return true
	else:
		return false
