extends Control

var need_to_erase = false

var speed = 0.0
var max_speed = 1.2
var accel = 0.04
var start_pause = true

var help_active = false

signal start_game

func _physics_process(_delta):
	speed += accel
	if (abs(speed) > abs(max_speed)):
		accel = -accel
	$TextureRect.rect_position.y += speed
	
	if (need_to_erase):
		modulate.a -= 0.03
		if (modulate.a <= 0):
			queue_free()
			
func _input(event):
	if not help_active and start_pause and event is InputEventScreenTouch and event.is_pressed():
		if Rect2($TapZone.get_global_rect().position, $TapZone.rect_size).has_point(event.position):
			get_tree().paused = false
			Events.emit_signal('start_game')
			need_to_erase = true
			start_pause = false
