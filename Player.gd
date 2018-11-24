extends Area2D
signal hit # defines custom signal player will emit when colliding with enemy

export (int) var speed # the export key word allows us to set its value in the inspector
var screensize # size of game window

func _ready(): # called when node enters scene tree
	screensize = get_viewport_rect().size
	hide() # player hidden when game starts

func _process(delta):
	var velocity = Vector2() # Player's movement vector
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"): # note that down is the positive
		velocity.y += 1
	if Input.is_action_pressed("ui_up"): # and up is negative
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed # normalization is to prevent the player moving faster
												 # if it moves diagonally (since 1,1 would be "more"
												 # than (1,0)
		$AnimatedSprite.play() # $ is shorthand for get_node() and returns the node at the relative path
							   # from this node. Since AnimatedSprite is a child of the current node,
							   # using $ is enough.
	else:
		$AnimatedSprite.stop()
		
	# as an example, holding right and down at the same time will set the velocity vector to (1,1)
	position += velocity * delta # new position is current position + vector*delta
	position.x = clamp(position.x, 0, screensize.x) # clamp restricts player to screen area.
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false # will not flip_v when horizontal mvmt present
		$AnimatedSprite.flip_h = velocity.x < 0 # set flip_h to true when left arrow is pressed
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0 # set flip_v to true when down arrow is pressed

func _on_Player_body_entered(body):
	hide() # player dissapears after being hit
	emit_signal("hit")
	$CollisionShape2D.disabled = true # disables collision shape to prevent any further hit signals

func start(pos): # call to reset player when starting new game
	position = pos
	show()
	$CollisionShape2D.disabled = false
