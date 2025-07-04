extends Label

@onready var heart: AnimatedSprite2D = $Heart
signal health_hits_zero

func _ready():
	heart.visible = false
	await heart.animation_finished
	heart.visible = true

func _set_health(health):
	self.text = "HEALTH:   "+ str(health)
	heart.play("heartbreak")
	check_health_hit_zero(health)

func check_health_hit_zero(health):
	if health <= 0:
		emit_signal("health_hits_zero")
