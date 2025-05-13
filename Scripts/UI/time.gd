extends Label

func _ready():
	$GameTime.start()

func time_left():
	var time_left = $GameTime.time_left
	var minute = floor(time_left/60)
	var second = int (time_left)%60
	return [minute,second]

func _process(delta):
	self.text = "%02d:%02d" % time_left()
