extends Area2D

@export var _speed = 400
@export var dodging = false
@export var attacking = false
var screen_size



# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if !dodging and !attacking:
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if Input.is_action_pressed("move_dodge"):
			dodging = true
			$AnimatedSprite2D.animation = "roll"
			$RollTimer.start()
		elif Input.is_action_pressed("move_quickAttack"):
			attacking = true
			$AnimatedSprite2D.animation = "fastAttack"
			$LightAttackTimer.start()
		elif Input.is_action_pressed("move_heavyAttack"):
			attacking = true
			$AnimatedSprite2D.animation = "heavyAttack"
			$HeavyAttackTimer.start()
	
	
	if dodging:
		velocity = velocity.normalized() * _speed * 1.5
	elif attacking:
		velocity = velocity.normalized() * 0
	else:
		if velocity.length() > 0:
			velocity = velocity.normalized() * _speed
		else:
			$AnimatedSprite2D.animation = "idle"
		
		if velocity.x != 0:
			$AnimatedSprite2D.animation = "walk_side"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = velocity.x < 0
		elif velocity.y < 0:
			$AnimatedSprite2D.animation = "walk_up"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = false
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = "walk_down"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = false
	
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)






func _on_roll_timer_timeout():
	dodging = false

func _on_light_attack_timer_timeout():
	attacking = false

func _on_heavy_attack_timer_timeout():
	attacking = false
