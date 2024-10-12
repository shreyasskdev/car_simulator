extends CanvasLayer

func _process(_delta):
	$FPSLabel.text = "FPS: " + str(Engine.get_frames_per_second())
	#$Speedometer.text = str(round($"../../Car".linear_velocity.length() * 3.6)) + "km/h"
	##$Speedometer.text = str($"../../Car".transform.basis.xfrom_inv $"../../Car".linear_velocity.z)) + "km/h"
	#
	#$RPM.text = "RPM: " + str(round($"../../Car".rpm)) + " GEAR: " + str($"../../Car".current_gear)
