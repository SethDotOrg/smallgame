extends State

@export var walk_state: State

func enter() -> void:
	super()
	parent.velocity.x = 0

func process_input(event: InputEvent) -> State:
	super(event)
	if check_movement(): 
		return walk_state
	return null

func process_physics(delta: float) -> State:
	parent.move_and_slide()
	return null

func check_movement() -> bool:
	return Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")
