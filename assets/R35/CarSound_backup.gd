extends AudioStreamPlayer3D

@export var min_pitch = 0.0
@export var max_pitch = 0.5
@export var min_volume_db = -10.0
@export var max_volume_db = 1.0

var current_rpm = 0.0
var max_rpm = 6000.0

func _process(delta):
	# Assuming you have a way to get the current speed
	#current_speed = get_parent().get_speed()
	current_rpm = $"../..".rpm  + ($"../..".current_gear * 100)
	
	# Calculate pitch based on speed
	var rpm_ratio = current_rpm / max_rpm
	var pitch = lerp(min_pitch, max_pitch, rpm_ratio)
	
	# Set the pitch
	pitch_scale = pitch
	
	# Calculate volume based on speed
	var volume = lerp(min_volume_db, max_volume_db, rpm_ratio)
	
	# Set the volume
	volume_db = volume
	
	# Ensure the sound is playing
	if not playing:
		play()
