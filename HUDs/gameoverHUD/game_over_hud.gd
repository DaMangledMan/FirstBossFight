extends CanvasLayer

signal start_game
signal quit_game


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func player_death_game_over_message():
	# shows the palyer death scene
	show_menu()

func boss_death_game_over_message():
	# shows the boss death scene
	show_menu()


func show_menu():
	$StartButton.show()
	$QuitButton.show()
	$GameNameLabel.show()

func _on_start_button_pressed():
	$StartButton.hide()
	$QuitButton.hide()
	$GameNameLabel.hide()
	start_game.emit()

func _on_quit_button_pressed():
	$StartButton.hide()
	$QuitButton.hide()
	$GameNameLabel.hide()
	quit_game.emit()
