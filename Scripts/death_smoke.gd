extends CPUParticles2D

@onready var time_created = Time.get_ticks_msec()

#wait 10 seconds and the clear the particles for cleanup
func _process(delta):
	if Time.get_ticks_msec() - time_created > 10000: #10 seconds
		queue_free()
