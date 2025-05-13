extends State

@export var idle_state: State

func enter() -> void:
	super()

func process_input(event: InputEvent) -> State:
	super(event)
	return null

func process_physics(delta: float) -> State:
	super(delta)
	speed = parent.speed #if we are in this state then we should be using the walk speed
	
	if parent.velocity.length() > 0:
		parent.velocity = parent.velocity.normalized() * speed #normalize the velocity so if we get velocity (x,y) = (1,1) 
													#it wont be faster then only and x or y being 1.
	parent.move_and_slide() #one of the options to get the player to move with the set velocity	
	

	if parent.velocity.x == 0 and parent.velocity.y == 0:#if on the floor and not horizontally moving
		return idle_state
	return null
	
