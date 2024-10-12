extends Node3D

# References to AudioStreamPlayer nodes
@onready var engine_loop = $EngineLoop
#@onready var start_sound = $StartSound
@onready var idle_sound = $IdleSound
#@onready var gear_shift_sound = $GearShiftSound
@onready var throttle_sound = $Throttle


# Engine loop parameters
@export var min_pitch = 0.2
@export var max_pitch = 1.0
@export var min_volume_db = 0.1
@export var max_volume_db = 1.0

var current_rpm = 0.0
var current_throttle = 0.0
var max_rpm = 5000.0
@onready var engine_running = true if $"..".speed > 0.9 and $"..".current_gear > 0 else false


func _ready():
	# Initialize idle sound
	#idle_sound.play()
	pass

func _process(delta):
	engine_running = true if $"..".speed > 0.9 and $"..".current_gear > 0 else false
	if engine_running:
		start_moving()
		update_engine_sound()
	if Input.is_action_just_released("front"):
		$turboCharger.play()

#
#func start_engine():
	#start_sound.play()
	#yield(start_sound, "finished")
	#engine_running = true
	#idle_sound.stop()
	#engine_loop.play()

#func stop_engine():
	#engine_running = false
	#engine_loop.stop()
	#idle_sound.play()

func update_engine_sound():
	# Assuming you have a way to get the current speed
	current_rpm = $"..".rpm
	current_throttle = $"..".throttle_val
	
	# Calculate pitch based on speed
	var rpm_ratio = current_rpm / max_rpm
	var throttle_ratio = current_throttle / 1
	var pitch = lerp(min_pitch, max_pitch, rpm_ratio)
	var throttle_pitch = lerp(min_pitch, max_pitch, throttle_ratio)
	
	# Set the pitch
	engine_loop.pitch_scale = pitch
	idle_sound.pitch_scale = 1.0 - pitch + 0.3
	throttle_sound.pitch_scale = throttle_pitch
	
	# Calculate volume based on speed
	var volume = lerp(min_volume_db, max_volume_db, rpm_ratio)
	var throttle_volume = lerp(min_volume_db, max_volume_db, throttle_ratio)
	
	# Set the volume
	engine_loop.volume_db = volume
	throttle_sound.volume_db = throttle_volume
	idle_sound.volume_db = 1.0 - volume + 0.3


#func shift_gear():
	#gear_shift_sound.play()

# Call this when the car starts moving from a stop
func start_moving():
	#idle_sound.stop()
	if not engine_loop.playing:
		engine_loop.play()
	if not throttle_sound.playing:
		throttle_sound.play()

# Call this when the car comes to a complete stop
#func stop_moving():
	#if current_speed == 0 and engine_running:
		#engine_loop.stop()
		#idle_sound.play()
