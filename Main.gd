extends Node

export (PackedScene) var Mob # sets a packedscene value in the inspector
var score

func _ready():
	randomize() # to use with mob randomizer in Mob scene

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$DeathSound.play()
	$Music.stop()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout(): # adds 1 to score every second after timeout
	score += 1
	$HUD.update_score(score)

func _on_MobTimer_timeout():
	# Choose random location on Path2D
	$MobPath/MobSpawnLocation.set_offset(randi())
	# Create mob instance and add it to scene
	var mob = Mob.instance()
	add_child(mob)
	# Set mob direction perpendicular to the path direction
	var direction = $MobPath/MobSpawnLocation.rotation + PI/2
	# Set mob positions to a random location
	mob.position = $MobPath/MobSpawnLocation.position
	#Add some randomness to direction
	direction += rand_range(-PI / 4, PI / 4) # ANGLES ARE IN RADIANS!
	mob.rotation = direction
	#choose velocity
	mob.set_linear_velocity(Vector2(rand_range(mob.min_speed, mob.max_speed),0).rotated(direction))