extends Node

var time



# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.hide()
	$Boss.hide()
	$Player.start($PlayerStartPosition.position)
	$Boss.start($BossStartPosition.position)
	$GameOverHUD.show_menu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_pressed("boss_second_phase"):
		$Boss.edit_health(1000)
	elif Input.is_action_pressed("kill_boss"):
		$Boss.edit_health(0)
	elif Input.is_action_pressed("kill_player"):
		$Player.edit_health(0)


func game_over():
	$TimeTimer.stop()
	
	if $Player.player_living():
		$GameOverHUD.boss_death_game_over_message()
	else:
		$GameOverHUD.player_death_game_over_message()


func new_game():
	time = 0
	$Player.show()
	$Boss.show()
	$Player.start($PlayerStartPosition.position)
	$Boss.start($BossStartPosition.position)

