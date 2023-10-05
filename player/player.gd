extends Area2D

@export var _speed = 200
@export var dodging = false
@export var healing = false
@export var attacking = false
@export var attack_type = "light"
@export var last_direction = "right"
var screen_size
var velocity




# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()
	velocity = Vector2.ZERO




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# determines the action of the player when inside an uninterruptable action
	if !dodging and !attacking and !healing:
		
		velocity = Vector2.ZERO
		
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if Input.is_action_pressed("move_dodge") and (velocity.length() > 0):
			dodging = true
			$DodgeTimer.start()
		elif Input.is_action_pressed("move_heal"):
			healing = true
			$HealTimer.start()
		elif Input.is_action_pressed("move_lightAttack"):
			attacking = true
			attack_type = "light"
			$LightAttackTimer.start()
		elif Input.is_action_pressed("move_heavyAttack"):
			attacking = true
			attack_type = "heavy"
			$HeavyAttackTimer.start()
	
	
	# determines what animation will play and controls the normalized velocity
	
	if dodging: # handles dodge case
		velocity = velocity.normalized() * _speed * 2.0
		
		if velocity.x > 0:
			$AnimatedSprite2D.animation = "dodge_right"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = false
			last_direction == "right"
		elif velocity.x < 0:
			$AnimatedSprite2D.animation = "dodge_right"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = true
			last_direction == "left"
		elif velocity.y < 0:
			$AnimatedSprite2D.animation = "dodge_up"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = false
			last_direction == "up"
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = "dodge_down"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = false
			last_direction == "down"
	
	
	elif healing: # handles heal case
		velocity = velocity.normalized() * _speed * .25
		
		if velocity.x > 0:
			$AnimatedSprite2D.animation = "heal_right"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = false
			last_direction == "right"
		elif velocity.x < 0:
			$AnimatedSprite2D.animation = "heal_right"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = true
			last_direction == "left"
		elif velocity.y < 0:
			$AnimatedSprite2D.animation = "heal_up"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = false
			last_direction == "up"
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = "heal_down"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = false
			last_direction == "down"
		else:
			if last_direction == "right":
				$AnimatedSprite2D.animation = "heal_right"
				$AnimatedSprite2D.flip_v = false
				$AnimatedSprite2D.flip_h = false
			elif last_direction == "left":
				$AnimatedSprite2D.animation = "heal_right"
				$AnimatedSprite2D.flip_v = false
				$AnimatedSprite2D.flip_h = true
			elif last_direction == "up":
				$AnimatedSprite2D.animation = "heal_up"
				$AnimatedSprite2D.flip_v = false
				$AnimatedSprite2D.flip_h = false
			elif last_direction == "down":
				$AnimatedSprite2D.animation = "heal_down"
				$AnimatedSprite2D.flip_v = false
				$AnimatedSprite2D.flip_h = false
	
	
	elif attacking and attack_type == "light": # handles light attack case
		velocity = velocity.normalized() * _speed * .1
		
		if velocity.x > 0:
			$AnimatedSprite2D.animation = "light_attack_right"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = false
			last_direction == "right"
		elif velocity.x < 0:
			$AnimatedSprite2D.animation = "light_attack_right"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = true
			last_direction == "left"
		elif velocity.y < 0:
			$AnimatedSprite2D.animation = "light_attack_up"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = false
			last_direction == "up"
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = "light_attack_down"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = false
			last_direction == "down"
		else:
			if last_direction == "right":
				$AnimatedSprite2D.animation = "light_attack_right"
				$AnimatedSprite2D.flip_v = false
				$AnimatedSprite2D.flip_h = false
			elif last_direction == "left":
				$AnimatedSprite2D.animation = "light_attack_right"
				$AnimatedSprite2D.flip_v = false
				$AnimatedSprite2D.flip_h = true
			elif last_direction == "up":
				$AnimatedSprite2D.animation = "light_attack_up"
				$AnimatedSprite2D.flip_v = false
				$AnimatedSprite2D.flip_h = false
			elif last_direction == "down":
				$AnimatedSprite2D.animation = "light_attack_down"
				$AnimatedSprite2D.flip_v = false
				$AnimatedSprite2D.flip_h = false
	
	
	elif attacking and attack_type == "heavy": # handles heavy attack case
		velocity = velocity.normalized() * _speed * .1
		
		if velocity.x > 0:
			$AnimatedSprite2D.animation = "heavy_attack_right"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = false
			last_direction == "right"
		elif velocity.x < 0:
			$AnimatedSprite2D.animation = "heavy_attack_right"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = true
			last_direction == "left"
		elif velocity.y < 0:
			$AnimatedSprite2D.animation = "heavy_attack_up"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = false
			last_direction == "up"
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = "heavy_attack_down"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = false
			last_direction == "down"
		else:
			if last_direction == "right":
				$AnimatedSprite2D.animation = "heavy_attack_right"
				$AnimatedSprite2D.flip_v = false
				$AnimatedSprite2D.flip_h = false
			elif last_direction == "left":
				$AnimatedSprite2D.animation = "heavy_attack_right"
				$AnimatedSprite2D.flip_v = false
				$AnimatedSprite2D.flip_h = true
			elif last_direction == "up":
				$AnimatedSprite2D.animation = "heavy_attack_up"
				$AnimatedSprite2D.flip_v = false
				$AnimatedSprite2D.flip_h = false
			elif last_direction == "down":
				$AnimatedSprite2D.animation = "heavy_attack_down"
				$AnimatedSprite2D.flip_v = false
				$AnimatedSprite2D.flip_h = false
	
	
	else: # handles normal movement case
		if velocity.length() > 0:
			velocity = velocity.normalized() * _speed
		else:
			velocity = Vector2.ZERO
			$AnimatedSprite2D.animation = "idle"
		
		if velocity.x > 0:
			$AnimatedSprite2D.animation = "walk_right"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = false
			last_direction == "right"
		elif velocity.x < 0:
			$AnimatedSprite2D.animation = "walk_right"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = true
			last_direction == "left"
		elif velocity.y < 0:
			$AnimatedSprite2D.animation = "walk_up"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = false
			last_direction == "up"
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = "walk_down"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = false
			last_direction == "down"
	
	
	# controls the movement on a perframe basis
	position += velocity * delta
	# prevents player from leaving the screen
	position = position.clamp(Vector2.ZERO, screen_size)






func _on_dodge_timer_timeout():
	dodging = false

func _on_heal_timer_timeout():
	healing = false

func _on_light_attack_timer_timeout():
	attacking = false

func _on_heavy_attack_timer_timeout():
	attacking = false
