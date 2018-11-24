extends CanvasLayer

signal start_game # creates signal that tells Main node that button is pressed

func show_message(text): # call this fct when we want to display message temporarily
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over(): # call this fct when player loses. Shows game over for 2 sec then returns to title
	show_message("Game Over")
	yield($MessageTimer, "timeout") # yield(object, signal). When signal received, execution will recommence.
									# yield basically pauses the current function until signal received.
	$StartButton.show()
	$MessageLabel.text = "Dodge the \nCreeps!"
	$MessageLabel.show()

func update_score(score): # call fct in main whenever score changes
	$ScoreLabel.text = str(score) 

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$MessageLabel.hide()