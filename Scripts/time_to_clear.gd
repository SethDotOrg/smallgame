extends Label

func _ready():
	var set_time = $TimerToClearTimer.wait_time
	var second = int (set_time)%60
	self.text = "%02d" % second

func _on_check_for_player_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		$TimerToClearTimer.start()

func time_left():
	var time_left = $TimerToClearTimer.time_left
	var second = int (time_left)%60
	return second

func _process(delta):
	self.text = "%02d" % time_left()

func _get_timer_for_score():
	return int(time_left()) #give just seconds back to the caller
