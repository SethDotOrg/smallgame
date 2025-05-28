extends CPUParticles2D


func _on_timer_timeout():
	#turn of processes on blood splatter to save preformance. we stop the particle before its finished 
	#so that it will stay on the grounds
	set_process(false)
	set_physics_process(false)
	set_process_input(false)
	set_process_internal(false)
	set_process_unhandled_input(false)
	set_process_unhandled_key_input(false)
