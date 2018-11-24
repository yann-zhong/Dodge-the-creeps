extends RigidBody2D

export (int) var min_speed # min speed at which mob can move
export (int) var max_speed # max speed at which mob can move
var mob_types = ["walk", "swim", "fly"]

func _ready():
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	# sets animation to one of the three inside mob_types.
	# note normally need to use randomize() to generate RNG seed

func _on_Visibility_screen_exited():
	queue_free() # delete themselves upon leaving scene
